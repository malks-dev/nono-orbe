<?php

declare(strict_types=1);

use NonoOrbe\Core\Config\AppConfig;
use NonoOrbe\Core\Config\DatabaseConfig;
use NonoOrbe\Core\Database\Connection;
use NonoOrbe\Core\Support\HealthCheck;

require '/var/www/core/bootstrap.php';

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

try {
    $appConfig = AppConfig::fromEnvironment();
    $databaseConfig = DatabaseConfig::fromEnvironment();
    $connection = new Connection($databaseConfig);

    $result = (new HealthCheck(
        $appConfig,
        $connection
    ))->run();
} catch (\Throwable) {
    $result = [
        'status' => 'error',
        'application' => [
            'status' => 'unavailable',
        ],
        'database' => [
            'status' => 'unknown',
        ],
    ];
}

http_response_code(
    $result['status'] === 'ok' ? 200 : 503
);

echo json_encode(
    $result,
    JSON_PRETTY_PRINT
    | JSON_UNESCAPED_SLASHES
    | JSON_UNESCAPED_UNICODE
    | JSON_THROW_ON_ERROR
);

echo PHP_EOL;