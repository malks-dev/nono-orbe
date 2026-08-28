USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_importacoes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    destino_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    solicitada_por_usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    usuario_destino_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    cliente_destino_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    origem_usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    origem_cliente_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,

    tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'avatar',
    formato VARCHAR(20)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'sql',
    estrategia VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'mesclar',
    status VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'recebida',

    contrato_identidade VARCHAR(100)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    versao_schema_orbe VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,

    arquivo_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    checksum_sha256 CHAR(64)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    checksum_validado TINYINT(1) NOT NULL DEFAULT 0,

    manifesto JSON DEFAULT NULL,
    resultado JSON DEFAULT NULL,

    snapshot_origem_em DATETIME(6) DEFAULT NULL,
    validada_em DATETIME(6) DEFAULT NULL,
    iniciada_em DATETIME(6) DEFAULT NULL,
    concluida_em DATETIME(6) DEFAULT NULL,
    cancelada_em DATETIME(6) DEFAULT NULL,

    erro_codigo VARCHAR(100)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    erro_mensagem VARCHAR(1000) DEFAULT NULL,

    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_importacoes_uuid (uuid),
    KEY idx_orbe_importacoes_usuario_destino (
        usuario_destino_uuid,
        status,
        criado_em
    ),
    KEY idx_orbe_importacoes_cliente_destino (
        cliente_destino_uuid,
        status,
        criado_em
    ),
    KEY idx_orbe_importacoes_origem (
        origem_instalacao_uuid,
        origem_usuario_uuid
    ),
    KEY idx_orbe_importacoes_arquivo (arquivo_uuid),
    KEY idx_orbe_importacoes_checksum (checksum_sha256),

    CONSTRAINT fk_orbe_importacoes_arquivo
        FOREIGN KEY (arquivo_uuid) REFERENCES orbe_arquivos (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS orbe_importacao_conflitos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    importacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    entidade_tipo VARCHAR(100)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    registro_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    campo VARCHAR(120)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '*',

    versao_local BIGINT UNSIGNED DEFAULT NULL,
    versao_origem BIGINT UNSIGNED DEFAULT NULL,
    atualizado_local_em DATETIME(6) DEFAULT NULL,
    atualizado_origem_em DATETIME(6) DEFAULT NULL,

    status VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'pendente',
    resolucao VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    resolvido_por_usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    detalhes JSON DEFAULT NULL,

    detectado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    resolvido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_importacao_conflitos_uuid (uuid),
    UNIQUE KEY uq_orbe_importacao_conflito_registro (
        importacao_uuid,
        entidade_tipo,
        registro_uuid,
        campo
    ),
    KEY idx_orbe_importacao_conflitos_status (
        importacao_uuid,
        status
    ),
    KEY idx_orbe_importacao_conflitos_registro (
        entidade_tipo,
        registro_uuid
    ),

    CONSTRAINT fk_orbe_importacao_conflitos_importacao
        FOREIGN KEY (importacao_uuid) REFERENCES orbe_importacoes (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('011_create_orbe_importacoes.sql');