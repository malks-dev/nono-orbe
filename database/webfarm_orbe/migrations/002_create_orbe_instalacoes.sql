USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_instalacoes (
    id TINYINT UNSIGNED NOT NULL,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    nome VARCHAR(150) DEFAULT NULL,
    modo_operacao VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    contrato_identidade VARCHAR(100)
        CHARACTER SET ascii COLLATE ascii_bin
        NOT NULL DEFAULT 'webfarm-core-identity/1.0',
    versao_aplicacao VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    ativa TINYINT(1) NOT NULL DEFAULT 1,
    metadados JSON DEFAULT NULL,
    inicializada_em DATETIME(6) NOT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_instalacoes_uuid (uuid),
    CONSTRAINT chk_orbe_instalacoes_unica CHECK (id = 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('002_create_orbe_instalacoes.sql');