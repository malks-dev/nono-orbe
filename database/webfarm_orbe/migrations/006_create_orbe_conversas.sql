USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_conversas (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    cliente_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    projeto_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    criada_por_usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'geral',
    titulo VARCHAR(180) DEFAULT NULL,
    status VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'ativa',

    ultima_mensagem_em DATETIME(6) DEFAULT NULL,
    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_conversas_uuid (uuid),
    KEY idx_orbe_conversas_cliente (
        cliente_uuid,
        status,
        ultima_mensagem_em
    ),
    KEY idx_orbe_conversas_projeto (
        projeto_uuid,
        status,
        ultima_mensagem_em
    ),
    KEY idx_orbe_conversas_criador (criada_por_usuario_uuid),
    KEY idx_orbe_conversas_origem (origem_instalacao_uuid),
    KEY idx_orbe_conversas_atualizacao (atualizado_em),
    KEY idx_orbe_conversas_excluido (excluido_em),

    CONSTRAINT chk_orbe_conversas_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS orbe_conversa_participantes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    conversa_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    participante_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    participante_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    nome_exibicao VARCHAR(150) DEFAULT NULL,
    papel VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'participante',
    metadados JSON DEFAULT NULL,

    entrou_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    saiu_em DATETIME(6) DEFAULT NULL,
    ativo TINYINT(1) NOT NULL DEFAULT 1,

    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_conversa_participantes_uuid (uuid),
    UNIQUE KEY uq_orbe_conversa_participante (
        conversa_uuid,
        participante_tipo,
        participante_uuid
    ),
    KEY idx_orbe_participantes_referencia (
        participante_tipo,
        participante_uuid,
        ativo
    ),
    KEY idx_orbe_participantes_origem (origem_instalacao_uuid),
    KEY idx_orbe_participantes_atualizacao (atualizado_em),
    KEY idx_orbe_participantes_excluido (excluido_em),

    CONSTRAINT fk_orbe_participantes_conversa
        FOREIGN KEY (conversa_uuid) REFERENCES orbe_conversas (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_orbe_participantes_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS orbe_mensagens (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    conversa_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    participante_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    respondendo_mensagem_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'texto',
    conteudo MEDIUMTEXT NOT NULL,
    status VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'enviada',
    metadados JSON DEFAULT NULL,

    enviada_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    editada_em DATETIME(6) DEFAULT NULL,
    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_mensagens_uuid (uuid),
    KEY idx_orbe_mensagens_conversa (
        conversa_uuid,
        enviada_em,
        id
    ),
    KEY idx_orbe_mensagens_participante (participante_uuid),
    KEY idx_orbe_mensagens_resposta (respondendo_mensagem_uuid),
    KEY idx_orbe_mensagens_origem (origem_instalacao_uuid),
    KEY idx_orbe_mensagens_atualizacao (atualizado_em),
    KEY idx_orbe_mensagens_excluido (excluido_em),

    CONSTRAINT fk_orbe_mensagens_conversa
        FOREIGN KEY (conversa_uuid) REFERENCES orbe_conversas (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT fk_orbe_mensagens_participante
        FOREIGN KEY (participante_uuid)
        REFERENCES orbe_conversa_participantes (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT fk_orbe_mensagens_resposta
        FOREIGN KEY (respondendo_mensagem_uuid)
        REFERENCES orbe_mensagens (uuid)
        ON UPDATE CASCADE ON DELETE SET NULL,

    CONSTRAINT chk_orbe_mensagens_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('006_create_orbe_conversas.sql');