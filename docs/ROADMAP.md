# Roadmap inicial

## v0.1.0 — Primeiro contêiner

* [x] PHP 8.3 com Apache em Docker
* [x] Porta local `9000`
* [x] Primeira página executável
* [x] Healthcheck do contêiner
* [x] Documentação versionada

## Próxima versão — Fundação do Core e dados

### Concluído

* [x] Estrutura inicial do Nono Orbe Core
* [x] Separação entre Core, distribuição Local e integração WebFarm
* [x] Contrato `webfarm-core-identity/1.0`
* [x] MySQL 8.4 no Compose
* [x] PDO MySQL na imagem PHP 8.3
* [x] Banco `webfarm_orbe`
* [x] Controle de migrations
* [x] Perfis e preferências
* [x] Categorias e atalhos
* [x] Conversas, participantes e mensagens
* [x] Arquivos e anexos
* [x] Recursos e vínculos com projetos
* [x] Solicitações e eventos
* [x] Registros de exportação e importação
* [x] Política de seeds sem dados pessoais
* [x] Validação em instalação MySQL descartável
* [x] Configuração central da aplicação
* [x] Conexão PDO utilizada pelo PHP
* [x] Endpoint `/health/`
* [x] Verificação da conexão com o MySQL
* [x] Verificação das migrations aplicadas
* [x] Executor incremental de migrations
* [x] Checksums SHA-256 e bloqueio concorrente

### Pendente

* [ ] Tratamento centralizado de erros
* [ ] Logs estruturados sem informações sensíveis

## Etapa seguinte — Primeiro acesso local

* [ ] Implementar o adaptador local do contrato de identidade
* [ ] Registrar a instalação com UUID v4
* [ ] Criar o primeiro usuário local
* [ ] Criar o cliente pessoal
* [ ] Criar o vínculo de administrador
* [ ] Criar o perfil Nono Orbe
* [ ] Criar categorias e preferências iniciais
* [ ] Impedir dois primeiros usuários concorrentes
* [ ] Implementar login e logout
* [ ] Implementar sessão segura
* [ ] Registrar eventos de autenticação

## ORBE Home dinâmica

* [ ] Separar layout, componentes e regras de apresentação
* [ ] Conectar a Home ao perfil autenticado
* [ ] Personalizar nome, idioma e fuso horário
* [ ] Carregar categorias do banco
* [ ] Carregar atalhos do banco
* [ ] Criar, editar, ordenar e ocultar atalhos
* [ ] Diferenciar os contextos Local, Portal e Admin
* [ ] Criar estado vazio para novos usuários
* [ ] Criar interface responsiva

## Comunicação

* [ ] Criar lista de conversas
* [ ] Criar tela de conversa
* [ ] Enviar mensagens de texto
* [ ] Adicionar participantes
* [ ] Associar conversa a cliente ou projeto
* [ ] Criar solicitações a partir de conversas
* [ ] Registrar histórico de solicitações
* [ ] Preparar adaptador para auxiliar do projeto
* [ ] Preparar adaptador para inteligência artificial
* [ ] Implementar anexos com validação

## Recursos e serviços

* [ ] Listar recursos locais
* [ ] Listar recursos fornecidos pela WebFarm
* [ ] Registrar bancos de dados do usuário
* [ ] Registrar sites e aplicações
* [ ] Registrar VPS e serviços externos
* [ ] Relacionar recursos a projetos
* [ ] Exibir apenas metadados autorizados
* [ ] Criar cofre separado para credenciais

## Exportação local

* [ ] Definir formato `orbe-avatar`
* [ ] Gerar manifesto
* [ ] Gerar checksum SHA-256
* [ ] Exportar perfil e preferências
* [ ] Exportar categorias e atalhos
* [ ] Validar escopo do cliente
* [ ] Impedir exportação de senhas e tokens
* [ ] Registrar arquivo gerado
* [ ] Criar processo manual de download

## Importação local

* [ ] Validar manifesto
* [ ] Validar checksum
* [ ] Validar versão do contrato
* [ ] Validar tabelas e colunas permitidas
* [ ] Mapear usuário e cliente de destino
* [ ] Detectar conflitos por UUID e versão
* [ ] Permitir manter dados locais
* [ ] Permitir utilizar dados de origem
* [ ] Registrar resultado da importação
* [ ] Impedir execução direta de SQL não validado

## Integração WebFarm

* [ ] Criar pacote ou adaptador Nono Orbe para o WebFarm
* [ ] Usar autenticação fornecida pelo `webfarm_core`
* [ ] Usar o layout Nono Orbe no Portal
* [ ] Usar componentes Nono Orbe no Admin
* [ ] Respeitar papéis e permissões do WebFarm
* [ ] Relacionar recursos aos sites e servidores do WebFarm
* [ ] Relacionar solicitações ao CRM
* [ ] Definir compatibilidade entre versões
* [ ] Documentar atualização independente do Core

## Futuro

* Sincronização automática entre servidor e localhost
* Resolução assistida de conflitos
* Espaços públicos e privados
* Pastas e projetos pessoais
* Busca unificada
* Assistente de projeto
* Integração com inteligências artificiais
* Gateways de pagamento configuráveis
* Provedores de e-mail configuráveis
* Publicação por subdomínio via WebFarm
* Aplicativos e extensões do ecossistema ORBE
