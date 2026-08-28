USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_perfis (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    usuario_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    nome_exibicao VARCHAR(150) DEFAULT NULL,
    biografia VARCHAR(1000) DEFAULT NULL,
    idioma VARCHAR(10)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'pt-BR',
    fuso_horario VARCHAR(64)
        CHARACTER SET ascii COLLATE ascii_bin
        NOT NULL DEFAULT 'America/Sao_Paulo',

    onboarding_concluido_em DATETIME(6) DEFAULT NULL,
    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_perfis_uuid (uuid),
    UNIQUE KEY uq_orbe_perfis_usuario (usuario_uuid),
    KEY idx_orbe_perfis_origem (origem_instalacao_uuid),
    KEY idx_orbe_perfis_atualizacao (atualizado_em),
    KEY idx_orbe_perfis_excluido (excluido_em),

    CONSTRAINT chk_orbe_perfis_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('003_create_orbe_perfis.sql');