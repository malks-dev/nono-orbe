<?php

declare(strict_types=1);

namespace NonoOrbe\Core\Support;

use NonoOrbe\Core\Config\AppConfig;
use NonoOrbe\Core\Database\Connection;
use Throwable;

final readonly class HealthCheck
{
    public function __construct(
        private AppConfig $appConfig,
        private Connection $connection
    ) {
    }

    /**
     * @return array{
     *     status: string,
     *     application: array{status: string, environment: string},
     *     database: array{status: string, migrations?: int}
     * }
     */
    public function run(): array
    {
        $this->appConfig->applyTimezone();

        try {
            $pdo = $this->connection->pdo();

            $databaseAvailable = (int) $pdo
                ->query('SELECT 1')
                ->fetchColumn() === 1;

            if (!$databaseAvailable) {
                return $this->databaseUnavailable();
            }

            $migrations = (int) $pdo
                ->query('SELECT COUNT(*) FROM schema_migrations')
                ->fetchColumn();

            return [
                'status' => 'ok',
                'application' => [
                    'status' => 'ok',
                    'environment' => $this->appConfig->environment,
                ],
                'database' => [
                    'status' => 'ok',
                    'migrations' => $migrations,
                ],
            ];
        } catch (Throwable) {
            return $this->databaseUnavailable();
        }
    }

    /**
     * @return array{
     *     status: string,
     *     application: array{status: string, environment: string},
     *     database: array{status: string}
     * }
     */
    private function databaseUnavailable(): array
    {
        return [
            'status' => 'error',
            'application' => [
                'status' => 'ok',
                'environment' => $this->appConfig->environment,
            ],
            'database' => [
                'status' => 'unavailable',
            ],
        ];
    }
}