<?php

declare(strict_types=1);

namespace NonoOrbe\Core\Config;

use RuntimeException;

final readonly class DatabaseConfig
{
    public function __construct(
        public string $host,
        public int $port,
        public string $database,
        public string $username,
        public string $password
    ) {
        self::validateHost($host);
        self::validatePort($port);
        self::validateDatabase($database);

        if (trim($username) === '') {
            throw new RuntimeException(
                'O usuário do banco não pode ficar vazio.'
            );
        }

        if ($password === '') {
            throw new RuntimeException(
                'A senha do banco não pode ficar vazia.'
            );
        }
    }

    public static function fromEnvironment(): self
    {
        $portValue = Environment::optional('DB_PORT', '3306') ?? '3306';

        if (!ctype_digit($portValue)) {
            throw new RuntimeException(
                'A variável DB_PORT deve conter uma porta numérica.'
            );
        }

        return new self(
            host: Environment::required('DB_HOST'),
            port: (int) $portValue,
            database: Environment::required('DB_NAME'),
            username: Environment::required('DB_USER'),
            password: Environment::required('DB_PASSWORD')
        );
    }

    public function dsn(): string
    {
        return sprintf(
            'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
            $this->host,
            $this->port,
            $this->database
        );
    }

    /**
     * @return array{
     *     host: string,
     *     port: int,
     *     database: string
     * }
     */
    public function safeSummary(): array
    {
        return [
            'host' => $this->host,
            'port' => $this->port,
            'database' => $this->database,
        ];
    }

    private static function validateHost(string $host): void
    {
        if (
            trim($host) === ''
            || str_contains($host, ';')
            || preg_match('/[\x00-\x1F\x7F]/', $host)
        ) {
            throw new RuntimeException(
                'A variável DB_HOST possui um endereço inválido.'
            );
        }
    }

    private static function validatePort(int $port): void
    {
        if ($port < 1 || $port > 65535) {
            throw new RuntimeException(
                'A variável DB_PORT está fora do intervalo permitido.'
            );
        }
    }

    private static function validateDatabase(string $database): void
    {
        if (!preg_match('/^[A-Za-z0-9_]+$/', $database)) {
            throw new RuntimeException(
                'A variável DB_NAME possui um nome inválido.'
            );
        }
    }
}