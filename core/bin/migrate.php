#!/usr/bin/env php
<?php

declare(strict_types=1);

use NonoOrbe\Core\Config\DatabaseConfig;
use NonoOrbe\Core\Database\Connection;
use NonoOrbe\Core\Database\MigrationRunner;

require dirname(__DIR__) . '/bootstrap.php';

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit(1);
}

$directory = $argv[1] ?? '/var/www/database/migrations';

try {
    $runner = new MigrationRunner(
        new Connection(DatabaseConfig::fromEnvironment()),
        $directory
    );

    $result = $runner->run();

    echo 'aplicadas=', count($result['applied']), PHP_EOL;
    echo 'ignoradas=', count($result['skipped']), PHP_EOL;
    echo 'checksums_atualizados=',
        count($result['checksums_updated']),
        PHP_EOL;

    foreach ($result['applied'] as $migration) {
        echo 'APLICADA: ', $migration, PHP_EOL;
    }

    foreach ($result['checksums_updated'] as $migration) {
        echo 'CHECKSUM: ', $migration, PHP_EOL;
    }
} catch (\Throwable $exception) {
    fwrite(
        STDERR,
        'ERRO: ' . $exception->getMessage() . PHP_EOL
    );

    exit(1);
}