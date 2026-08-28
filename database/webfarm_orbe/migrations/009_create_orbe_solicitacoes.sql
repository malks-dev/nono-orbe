USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_solicitacoes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    cliente_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    solicitante_usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    projeto_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    recurso_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    conversa_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,

    tipo VARCHAR(50)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    titulo VARCHAR(180) NOT NULL,
    descricao TEXT NOT NULL,
    prioridade VARCHAR(20)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'normal',
    status VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'aberta',

    destino_atendimento_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    responsavel_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    responsavel_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,

    prazo_desejado_em DATETIME(6) DEFAULT NULL,
    aceita_em DATETIME(6) DEFAULT NULL,
    concluida_em DATETIME(6) DEFAULT NULL,
    cancelada_em DATETIME(6) DEFAULT NULL,
    metadados JSON DEFAULT NULL,

    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_solicitacoes_uuid (uuid),
    KEY idx_orbe_solicitacoes_cliente (
        cliente_uuid,
        status,
        prioridade,
        criado_em
    ),
    KEY idx_orbe_solicitacoes_solicitante (
        solicitante_usuario_uuid,
        status
    ),
    KEY idx_orbe_solicitacoes_projeto (projeto_uuid),
    KEY idx_orbe_solicitacoes_recurso (recurso_uuid),
    KEY idx_orbe_solicitacoes_conversa (conversa_uuid),
    KEY idx_orbe_solicitacoes_responsavel (
        responsavel_tipo,
        responsavel_uuid,
        status
    ),
    KEY idx_orbe_solicitacoes_origem (origem_instalacao_uuid),
    KEY idx_orbe_solicitacoes_atualizacao (atualizado_em),
    KEY idx_orbe_solicitacoes_excluido (excluido_em),

    CONSTRAINT fk_orbe_solicitacoes_recurso
        FOREIGN KEY (recurso_uuid) REFERENCES orbe_recursos (uuid)
        ON UPDATE CASCADE ON DELETE SET NULL,

    CONSTRAINT fk_orbe_solicitacoes_conversa
        FOREIGN KEY (conversa_uuid) REFERENCES orbe_conversas (uuid)
        ON UPDATE CASCADE ON DELETE SET NULL,

    CONSTRAINT chk_orbe_solicitacoes_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS orbe_solicitacao_eventos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    solicitacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    ator_tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    ator_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    evento_tipo VARCHAR(50)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    status_anterior VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    status_novo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    descricao TEXT DEFAULT NULL,
    metadados JSON DEFAULT NULL,

    ocorrido_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_solicitacao_eventos_uuid (uuid),
    KEY idx_orbe_solicitacao_eventos_solicitacao (
        solicitacao_uuid,
        ocorrido_em
    ),
    KEY idx_orbe_solicitacao_eventos_ator (
        ator_tipo,
        ator_uuid,
        ocorrido_em
    ),
    KEY idx_orbe_solicitacao_eventos_origem (origem_instalacao_uuid),
    KEY idx_orbe_solicitacao_eventos_excluido (excluido_em),

    CONSTRAINT fk_orbe_solicitacao_eventos_solicitacao
        FOREIGN KEY (solicitacao_uuid) REFERENCES orbe_solicitacoes (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_orbe_solicitacao_eventos_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('009_create_orbe_solicitacoes.sql');