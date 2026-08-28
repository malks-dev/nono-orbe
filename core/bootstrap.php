<?php

declare(strict_types=1);

spl_autoload_register(
    static function (string $classe): void {
        $prefixo = 'NonoOrbe\\Core\\';

        if (!str_starts_with($classe, $prefixo)) {
            return;
        }

        $nomeRelativo = substr($classe, strlen($prefixo));
        $caminhoRelativo = str_replace('\\', '/', $nomeRelativo);

        $arquivo = __DIR__ . '/src/' . $caminhoRelativo . '.php';

        if (is_file($arquivo)) {
            require_once $arquivo;
        }
    }
);