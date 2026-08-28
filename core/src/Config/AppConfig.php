<?php

declare(strict_types=1);

namespace NonoOrbe\Core\Config;

use DateTimeZone;
use RuntimeException;

final readonly class AppConfig
{
    private const AMBIENTES_VALIDOS = [
        'development',
        'testing',
        'staging',
        'production',
    ];

    public function __construct(
        public string $environment,
        public bool $debug,
        public string $timezone
    ) {
    }

    public static function fromEnvironment(): self
    {
        $environment = strtolower(
            Environment::optional('APP_ENV', 'production')
                ?? 'production'
        );

        if (!in_array($environment, self::AMBIENTES_VALIDOS, true)) {
            throw new RuntimeException(
                'A variável APP_ENV possui um ambiente inválido.'
            );
        }

        $timezone = Environment::optional('TZ', 'UTC') ?? 'UTC';

        if (!in_array($timezone, DateTimeZone::listIdentifiers(), true)) {
            throw new RuntimeException(
                'A variável TZ possui um fuso horário inválido.'
            );
        }

        return new self(
            environment: $environment,
            debug: self::parseBoolean('APP_DEBUG', false),
            timezone: $timezone
        );
    }

    public function applyTimezone(): void
    {
        if (!date_default_timezone_set($this->timezone)) {
            throw new RuntimeException(
                'Não foi possível configurar o fuso horário da aplicação.'
            );
        }
    }

    public function isProduction(): bool
    {
        return $this->environment === 'production';
    }

    private static function parseBoolean(
        string $nome,
        bool $padrao
    ): bool {
        $valor = Environment::optional($nome);

        if ($valor === null) {
            return $padrao;
        }

        return match (strtolower(trim($valor))) {
            '1', 'true', 'yes', 'on' => true,
            '0', 'false', 'no', 'off' => false,
            default => throw new RuntimeException(
                sprintf(
                    'A variável de ambiente "%s" deve ser booleana.',
                    $nome
                )
            ),
        };
    }
}