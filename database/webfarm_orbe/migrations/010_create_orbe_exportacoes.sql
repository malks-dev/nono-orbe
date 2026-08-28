USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_exportacoes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    cliente_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    solicitada_por_usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    tipo VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'avatar',
    formato VARCHAR(20)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'sql',
    contrato_identidade VARCHAR(100)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    versao_schema_orbe VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    status VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'solicitada',
    escopo JSON NOT NULL,
    manifesto JSON DEFAULT NULL,

    arquivo_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    checksum_sha256 CHAR(64)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,

    snapshot_em DATETIME(6) DEFAULT NULL,
    iniciada_em DATETIME(6) DEFAULT NULL,
    concluida_em DATETIME(6) DEFAULT NULL,
    expira_em DATETIME(6) DEFAULT NULL,
    baixada_em DATETIME(6) DEFAULT NULL,

    erro_codigo VARCHAR(100)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    erro_mensagem VARCHAR(1000) DEFAULT NULL,

    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_exportacoes_uuid (uuid),
    UNIQUE KEY uq_orbe_exportacoes_arquivo (arquivo_uuid),
    KEY idx_orbe_exportacoes_usuario (
        usuario_uuid,
        status,
        criado_em
    ),
    KEY idx_orbe_exportacoes_cliente (
        cliente_uuid,
        status,
        criado_em
    ),
    KEY idx_orbe_exportacoes_solicitante (
        solicitada_por_usuario_uuid,
        criado_em
    ),
    KEY idx_orbe_exportacoes_expiracao (status, expira_em),
    KEY idx_orbe_exportacoes_origem (origem_instalacao_uuid),

    CONSTRAINT fk_orbe_exportacoes_arquivo
        FOREIGN KEY (arquivo_uuid) REFERENCES orbe_arquivos (uuid)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('010_create_orbe_exportacoes.sql');