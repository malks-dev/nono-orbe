<?php

declare(strict_types=1);

namespace NonoOrbe\Core\Config;

use InvalidArgumentException;
use RuntimeException;

final class Environment
{
    public static function optional(
        string $nome,
        ?string $padrao = null
    ): ?string {
        self::validarNome($nome);

        $valor = getenv($nome);

        if ($valor === false || trim($valor) === '') {
            return $padrao;
        }

        return $valor;
    }

    public static function required(string $nome): string
    {
        $valor = self::optional($nome);

        if ($valor === null) {
            throw new RuntimeException(
                sprintf(
                    'A variável de ambiente obrigatória "%s" não foi configurada.',
                    $nome
                )
            );
        }

        return $valor;
    }

    private static function validarNome(string $nome): void
    {
        if (!preg_match('/^[A-Z][A-Z0-9_]*$/', $nome)) {
            throw new InvalidArgumentException(
                'Nome de variável de ambiente inválido.'
            );
        }
    }
}