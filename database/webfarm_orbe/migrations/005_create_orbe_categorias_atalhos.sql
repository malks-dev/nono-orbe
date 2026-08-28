USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_categorias (
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

    nome VARCHAR(100) NOT NULL,
    slug VARCHAR(100)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    icone VARCHAR(100) DEFAULT NULL,
    cor VARCHAR(30) DEFAULT NULL,
    ordem SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    visivel TINYINT(1) NOT NULL DEFAULT 1,

    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_categorias_uuid (uuid),
    UNIQUE KEY uq_orbe_categorias_escopo_slug (
        perfil_uuid,
        contexto_tipo,
        contexto_uuid,
        slug
    ),
    KEY idx_orbe_categorias_origem (origem_instalacao_uuid),
    KEY idx_orbe_categorias_contexto (
        perfil_uuid,
        contexto_tipo,
        contexto_uuid,
        visivel,
        ordem
    ),
    KEY idx_orbe_categorias_atualizacao (atualizado_em),
    KEY idx_orbe_categorias_excluido (excluido_em),

    CONSTRAINT fk_orbe_categorias_perfil
        FOREIGN KEY (perfil_uuid) REFERENCES orbe_perfis (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_orbe_categorias_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS orbe_atalhos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    perfil_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    categoria_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    contexto_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'global',
    contexto_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin
        NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000',

    titulo VARCHAR(150) NOT NULL,
    descricao VARCHAR(255) DEFAULT NULL,
    destino_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'url',
    destino VARCHAR(2048) NOT NULL,
    icone VARCHAR(100) DEFAULT NULL,
    cor VARCHAR(30) DEFAULT NULL,
    ordem SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    visivel TINYINT(1) NOT NULL DEFAULT 1,
    abre_nova_aba TINYINT(1) NOT NULL DEFAULT 0,

    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_atalhos_uuid (uuid),
    KEY idx_orbe_atalhos_perfil_contexto (
        perfil_uuid,
        contexto_tipo,
        contexto_uuid,
        visivel,
        ordem
    ),
    KEY idx_orbe_atalhos_categoria (categoria_uuid, visivel, ordem),
    KEY idx_orbe_atalhos_origem (origem_instalacao_uuid),
    KEY idx_orbe_atalhos_atualizacao (atualizado_em),
    KEY idx_orbe_atalhos_excluido (excluido_em),

    CONSTRAINT fk_orbe_atalhos_perfil
        FOREIGN KEY (perfil_uuid) REFERENCES orbe_perfis (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT fk_orbe_atalhos_categoria
        FOREIGN KEY (categoria_uuid) REFERENCES orbe_categorias (uuid)
        ON UPDATE CASCADE ON DELETE SET NULL,

    CONSTRAINT chk_orbe_atalhos_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('005_create_orbe_categorias_atalhos.sql');