# Changelog

Todas as mudanças relevantes do Nono Orbe serão documentadas neste arquivo.

O projeto utiliza versionamento semântico: `MAJOR.MINOR.PATCH`.

## [Não lançado]

### Adicionado

* Estrutura inicial reutilizável do Nono Orbe Core.
* Contrato de identidade `webfarm-core-identity/1.0`.
* Banco MySQL `webfarm_orbe`.
* Controle de migrations por `schema_migrations`.
* Identificação da instalação Nono Orbe.
* Perfis e preferências por contexto.
* Categorias e atalhos personalizados.
* Conversas, participantes e mensagens.
* Metadados de arquivos e anexos.
* Catálogo de recursos locais, WebFarm e externos.
* Solicitações de ajuda, serviços e histórico de eventos.
* Registros de exportações, importações e conflitos.
* Política de seeds sem usuários ou dados pessoais.
* Documentação técnica do Core, banco e contratos.
* Processo 002 com decisões e validações da fundação.
* Autoload próprio para as classes do Core.
* Validação central de ambiente, debug, timezone e banco.
* Conexão PDO reutilizável com sessão MySQL em UTC.
* Endpoint público `/health/` para aplicação e banco.
* Executor incremental de migrations com bloqueio exclusivo.
* Checksums SHA-256 para migrations aplicadas.

### Alterado

* Ambiente Docker expandido com MySQL 8.4.
* Imagem PHP 8.3 ampliada com PDO MySQL.
* Compose preparado para instalações isoladas por `ORBE_PROJECT_SLUG`.
* Serviço web configurado para aguardar a saúde do MySQL.
* MySQL publicado somente em `127.0.0.1`.
* `.env.example` ampliado com configurações públicas do banco.
* `.gitignore` ampliado para proteger storage, backups, exportações, dumps e chaves privadas.
* Core incluído na imagem e montado como somente leitura em desenvolvimento.
* Healthcheck do serviço web direcionado ao endpoint real `/health/`.
* Migrations disponibilizadas ao serviço web para atualizações incrementais.
* Banco lógico da distribuição Local fixado em `webfarm_orbe`.

### Segurança

* O `.env` real permanece fora do Git.
* Senhas de root e aplicação são configuradas individualmente.
* Migrations e seeds não incluem usuários, credenciais ou dados pessoais.
* Exportações e importações foram planejadas sem transportar senhas, tokens ou sessões.
* Relações externas utilizam UUIDs em vez de IDs numéricos internos.
* Respostas de saúde não expõem senha, DSN ou detalhes de exceções.
* Alterações em migrations aplicadas são detectadas por checksum.
* Execuções concorrentes de migrations são impedidas por bloqueio no MySQL.

### Validado

* As 11 migrations foram executadas em MySQL 8.4.
* As 18 tabelas foram criadas em uma instalação descartável.
* A instalação limpa iniciou com zero perfis, conversas e dados pessoais.
* O log do teste limpo não apresentou erros.
* O endpoint respondeu HTTP `200` com aplicação e banco saudáveis.
* O endpoint respondeu HTTP `503` durante indisponibilidade controlada do MySQL.
* O serviço recuperou automaticamente o estado saudável após o retorno do banco.
* Os 11 registros legados receberam checksums distintos.
* Execuções repetidas do migrador não reaplicaram estrutura.
* Uma alteração temporária em migration aplicada foi rejeitada.
* Uma migration temporária pendente foi aplicada e registrada.
* O endpoint foi acessado pela rede local na porta `9000`.

## [0.1.0] - 2026-08-27

### Adicionado

* Primeiro contêiner PHP 8.3 com Apache.
* Página inicial “Hello, World!” do Nono Orbe.
* Publicação local na porta `9000`.
* Healthcheck HTTP do serviço.
* Estrutura inicial de documentação viva.
