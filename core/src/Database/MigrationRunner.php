<?php

declare(strict_types=1);

namespace NonoOrbe\Core\Database;

use PDO;
use RuntimeException;
use Throwable;

final readonly class MigrationRunner
{
    public function __construct(
        private Connection $connection,
        private string $directory
    ) {
    }

    /**
     * @return array{
     *     applied: list<string>,
     *     skipped: list<string>,
     *     checksums_updated: list<string>
     * }
     */
    public function run(): array
    {
        $files = $this->migrationFiles();
        $pdo = $this->connection->pdo();
        $lockName = $this->lockName($pdo);

        $this->acquireLock($pdo, $lockName);

        try {
            $registered = $this->registeredMigrations($pdo);

            $this->validateHistory($files, $registered);

            $result = [
                'applied' => [],
                'skipped' => [],
                'checksums_updated' => [],
            ];

            foreach ($files as $name => $file) {
                if (array_key_exists($name, $registered)) {
                    $registeredChecksum = $registered[$name];

                    if ($registeredChecksum === null) {
                        $this->updateChecksum(
                            $pdo,
                            $name,
                            $file['checksum']
                        );

                        $result['checksums_updated'][] = $name;
                    } else {
                        $result['skipped'][] = $name;
                    }

                    continue;
                }

                $this->executeMigration($pdo, $file['path']);
                $this->registerMigration(
                    $pdo,
                    $name,
                    $file['checksum']
                );

                $result['applied'][] = $name;
            }

            return $result;
        } finally {
            $this->releaseLock($pdo, $lockName);
        }
    }

    /**
     * @return array<
     *     string,
     *     array{path: string, checksum: string}
     * >
     */
    private function migrationFiles(): array
    {
        if (!is_dir($this->directory)) {
            throw new RuntimeException(
                'O diretório de migrations não foi encontrado.'
            );
        }

        $paths = glob(
            rtrim($this->directory, '/') . '/*.sql'
        );

        if ($paths === false || $paths === []) {
            throw new RuntimeException(
                'Nenhuma migration foi encontrada.'
            );
        }

        sort($paths, SORT_STRING);

        $files = [];
        $prefixes = [];

        foreach ($paths as $path) {
            $name = basename($path);

            if (!preg_match('/^[0-9]{3}_[a-z0-9_]+\.sql$/', $name)) {
                throw new RuntimeException(
                    sprintf('Nome de migration inválido: "%s".', $name)
                );
            }

            $prefix = substr($name, 0, 3);

            if (isset($prefixes[$prefix])) {
                throw new RuntimeException(
                    sprintf(
                        'Prefixo de migration duplicado: "%s".',
                        $prefix
                    )
                );
            }

            $checksum = hash_file('sha256', $path);

            if ($checksum === false) {
                throw new RuntimeException(
                    sprintf(
                        'Não foi possível calcular o checksum de "%s".',
                        $name
                    )
                );
            }

            $prefixes[$prefix] = true;
            $files[$name] = [
                'path' => $path,
                'checksum' => $checksum,
            ];
        }

        if (array_key_first($files) !== '001_create_schema_migrations.sql') {
            throw new RuntimeException(
                'A migration inicial do controle de schema está ausente.'
            );
        }

        return $files;
    }

    /**
     * @return array<string, string|null>
     */
    private function registeredMigrations(PDO $pdo): array
    {
        $exists = (int) $pdo->query(
            <<<'SQL'
            SELECT COUNT(*)
            FROM information_schema.tables
            WHERE table_schema = DATABASE()
              AND table_name = 'schema_migrations'
            SQL
        )->fetchColumn();

        if ($exists !== 1) {
            return [];
        }

        $statement = $pdo->query(
            <<<'SQL'
            SELECT migration, checksum
            FROM schema_migrations
            ORDER BY migration
            SQL
        );

        /** @var array<string, string|null> $registered */
        $registered = $statement->fetchAll(PDO::FETCH_KEY_PAIR);

        return $registered;
    }

    /**
     * @param array<string, array{path: string, checksum: string}> $files
     * @param array<string, string|null> $registered
     */
    private function validateHistory(
        array $files,
        array $registered
    ): void {
        foreach ($registered as $name => $checksum) {
            if (!isset($files[$name])) {
                throw new RuntimeException(
                    sprintf(
                        'A migration registrada "%s" não existe no código.',
                        $name
                    )
                );
            }

            if (
                $checksum !== null
                && !hash_equals($checksum, $files[$name]['checksum'])
            ) {
                throw new RuntimeException(
                    sprintf(
                        'O conteúdo da migration "%s" foi alterado.',
                        $name
                    )
                );
            }
        }
    }

    private function executeMigration(PDO $pdo, string $path): void
    {
        $sql = file_get_contents($path);

        if ($sql === false || trim($sql) === '') {
            throw new RuntimeException(
                sprintf(
                    'A migration "%s" está vazia ou ilegível.',
                    basename($path)
                )
            );
        }

        if ($pdo->exec($sql) === false) {
            throw new RuntimeException(
                sprintf(
                    'Não foi possível executar a migration "%s".',
                    basename($path)
                )
            );
        }
    }

    private function registerMigration(
        PDO $pdo,
        string $name,
        string $checksum
    ): void {
        $statement = $pdo->prepare(
            <<<'SQL'
            INSERT INTO schema_migrations (migration, checksum)
            VALUES (:migration, :checksum)
            ON DUPLICATE KEY UPDATE
                checksum = COALESCE(checksum, :updated_checksum)
            SQL
        );

        $statement->execute([
            'migration' => $name,
            'checksum' => $checksum,
            'updated_checksum' => $checksum,
        ]);

        $verification = $pdo->prepare(
            <<<'SQL'
            SELECT checksum
            FROM schema_migrations
            WHERE migration = :migration
            SQL
        );

        $verification->execute(['migration' => $name]);
        $storedChecksum = $verification->fetchColumn();

        if (
            !is_string($storedChecksum)
            || !hash_equals($checksum, $storedChecksum)
        ) {
            throw new RuntimeException(
                sprintf(
                    'Não foi possível registrar a migration "%s".',
                    $name
                )
            );
        }
    }

    private function updateChecksum(
        PDO $pdo,
        string $name,
        string $checksum
    ): void {
        $statement = $pdo->prepare(
            <<<'SQL'
            UPDATE schema_migrations
            SET checksum = :checksum
            WHERE migration = :migration
              AND checksum IS NULL
            SQL
        );

        $statement->execute([
            'migration' => $name,
            'checksum' => $checksum,
        ]);

        if ($statement->rowCount() !== 1) {
            throw new RuntimeException(
                sprintf(
                    'Não foi possível atualizar o checksum de "%s".',
                    $name
                )
            );
        }
    }

    private function lockName(PDO $pdo): string
    {
        $database = $pdo->query('SELECT DATABASE()')->fetchColumn();

        if (!is_string($database) || $database === '') {
            throw new RuntimeException(
                'Não foi possível identificar o banco atual.'
            );
        }

        return 'nono_orbe:migrations:'
            . substr(hash('sha256', $database), 0, 32);
    }

    private function acquireLock(PDO $pdo, string $lockName): void
    {
        $statement = $pdo->prepare(
            'SELECT GET_LOCK(:lock_name, 10)'
        );
        $statement->execute(['lock_name' => $lockName]);

        if ((int) $statement->fetchColumn() !== 1) {
            throw new RuntimeException(
                'Não foi possível obter o bloqueio das migrations.'
            );
        }
    }

    private function releaseLock(PDO $pdo, string $lockName): void
    {
        try {
            $statement = $pdo->prepare(
                'SELECT RELEASE_LOCK(:lock_name)'
            );
            $statement->execute(['lock_name' => $lockName]);
        } catch (Throwable) {
            // A conexão também libera o bloqueio ao ser encerrada.
        }
    }
}