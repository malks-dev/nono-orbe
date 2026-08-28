USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_recursos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    cliente_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    criado_por_usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    tipo VARCHAR(50)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    gerenciado_por_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    referencia_externa VARCHAR(190)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(1000) DEFAULT NULL,
    endpoint_publico VARCHAR(2048) DEFAULT NULL,
    status VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'ativo',

    configuracao_publica JSON DEFAULT NULL,
    metadados JSON DEFAULT NULL,

    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_recursos_uuid (uuid),
    UNIQUE KEY uq_orbe_recursos_referencia (
        origem_tipo,
        referencia_externa
    ),
    KEY idx_orbe_recursos_cliente (
        cliente_uuid,
        status,
        tipo
    ),
    KEY idx_orbe_recursos_origem_tipo (origem_tipo, tipo),
    KEY idx_orbe_recursos_gerenciado_por (gerenciado_por_tipo),
    KEY idx_orbe_recursos_instalacao (origem_instalacao_uuid),
    KEY idx_orbe_recursos_atualizacao (atualizado_em),
    KEY idx_orbe_recursos_excluido (excluido_em),

    CONSTRAINT chk_orbe_recursos_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS orbe_recurso_projetos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    recurso_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    projeto_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    papel VARCHAR(50)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'principal',

    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_recurso_projetos_uuid (uuid),
    UNIQUE KEY uq_orbe_recurso_projeto (
        recurso_uuid,
        projeto_uuid
    ),
    KEY idx_orbe_recurso_projetos_projeto (projeto_uuid),
    KEY idx_orbe_recurso_projetos_origem (origem_instalacao_uuid),
    KEY idx_orbe_recurso_projetos_atualizacao (atualizado_em),
    KEY idx_orbe_recurso_projetos_excluido (excluido_em),

    CONSTRAINT fk_orbe_recurso_projetos_recurso
        FOREIGN KEY (recurso_uuid) REFERENCES orbe_recursos (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_orbe_recurso_projetos_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('008_create_orbe_recursos.sql');