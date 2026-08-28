USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_preferencias (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    perfil_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    contexto_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'global',
    contexto_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin
        NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000',

    chave VARCHAR(120)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    valor JSON NOT NULL,

    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_preferencias_uuid (uuid),
    UNIQUE KEY uq_orbe_preferencias_escopo (
        perfil_uuid,
        contexto_tipo,
        contexto_uuid,
        chave
    ),
    KEY idx_orbe_preferencias_origem (origem_instalacao_uuid),
    KEY idx_orbe_preferencias_contexto (contexto_tipo, contexto_uuid),
    KEY idx_orbe_preferencias_atualizacao (atualizado_em),
    KEY idx_orbe_preferencias_excluido (excluido_em),

    CONSTRAINT fk_orbe_preferencias_perfil
        FOREIGN KEY (perfil_uuid) REFERENCES orbe_perfis (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_orbe_preferencias_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('004_create_orbe_preferencias.sql');