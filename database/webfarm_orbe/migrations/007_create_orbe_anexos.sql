USE webfarm_orbe;

CREATE TABLE IF NOT EXISTS orbe_arquivos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    cliente_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    enviado_por_usuario_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    provedor VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'local',
    chave_armazenamento VARCHAR(1024) NOT NULL,
    nome_original VARCHAR(255) NOT NULL,
    extensao VARCHAR(20)
        CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
    mime_type VARCHAR(150)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    tamanho_bytes BIGINT UNSIGNED NOT NULL,
    checksum_sha256 CHAR(64)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    visibilidade VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'privado',
    status VARCHAR(30)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'pendente',
    metadados JSON DEFAULT NULL,

    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_arquivos_uuid (uuid),
    KEY idx_orbe_arquivos_cliente (
        cliente_uuid,
        status,
        criado_em
    ),
    KEY idx_orbe_arquivos_usuario (enviado_por_usuario_uuid),
    KEY idx_orbe_arquivos_checksum (checksum_sha256),
    KEY idx_orbe_arquivos_origem (origem_instalacao_uuid),
    KEY idx_orbe_arquivos_atualizacao (atualizado_em),
    KEY idx_orbe_arquivos_excluido (excluido_em),

    CONSTRAINT chk_orbe_arquivos_tamanho CHECK (tamanho_bytes >= 0),
    CONSTRAINT chk_orbe_arquivos_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS orbe_mensagem_anexos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    mensagem_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    arquivo_uuid CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origem_instalacao_uuid CHAR(36)
        CHARACTER SET ascii COLLATE ascii_bin NOT NULL,

    ordem SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    versao BIGINT UNSIGNED NOT NULL DEFAULT 1,
    excluido_em DATETIME(6) DEFAULT NULL,
    criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),

    PRIMARY KEY (id),
    UNIQUE KEY uq_orbe_mensagem_anexos_uuid (uuid),
    UNIQUE KEY uq_orbe_mensagem_arquivo (
        mensagem_uuid,
        arquivo_uuid
    ),
    KEY idx_orbe_mensagem_anexos_arquivo (arquivo_uuid),
    KEY idx_orbe_mensagem_anexos_origem (origem_instalacao_uuid),
    KEY idx_orbe_mensagem_anexos_atualizacao (atualizado_em),
    KEY idx_orbe_mensagem_anexos_excluido (excluido_em),

    CONSTRAINT fk_orbe_mensagem_anexos_mensagem
        FOREIGN KEY (mensagem_uuid) REFERENCES orbe_mensagens (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT fk_orbe_mensagem_anexos_arquivo
        FOREIGN KEY (arquivo_uuid) REFERENCES orbe_arquivos (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_orbe_mensagem_anexos_versao CHECK (versao >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO schema_migrations (migration)
VALUES ('007_create_orbe_anexos.sql');
