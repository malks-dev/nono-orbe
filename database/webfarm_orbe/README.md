# webfarm_orbe

O nome lógico `webfarm_orbe` é canônico nas distribuições Local e WebFarm.

Banco da experiência personalizada do Nono Orbe.

O esquema foi projetado para funcionar em dois ambientes:

* Nono Orbe Local;
* integração do Nono Orbe com o WebFarm.

Identidade, autenticação, clientes e permissões não pertencem a este banco. Essas informações são fornecidas pelo contrato `webfarm-core-identity`.

## Tecnologias validadas

| Componente | Versão                          |
| ---------- | ------------------------------- |
| PHP        | 8.3                             |
| Apache     | Imagem oficial `php:8.3-apache` |
| MySQL      | 8.4                             |
| Driver PHP | PDO MySQL                       |
| Charset    | `utf8mb4`                       |
| Collation  | `utf8mb4_0900_ai_ci`            |
| Engine     | InnoDB                          |

## Responsabilidades

O banco `webfarm_orbe` armazena:

* identificação da instalação Nono Orbe;
* perfil personalizado;
* preferências por contexto;
* categorias e atalhos;
* conversas e mensagens;
* metadados de arquivos;
* recursos disponíveis ao cliente;
* solicitações de ajuda ou serviço;
* registros de exportação;
* registros de importação e conflitos.

O banco não armazena:

* autenticação;
* sessões;
* senhas;
* tokens;
* clientes completos;
* credenciais de infraestrutura;
* chaves de API;
* arquivos binários;
* dados pertencentes ao CRM.

## Contrato de identidade

```text
Contrato: webfarm-core-identity
Versão: 1.0
```

O Nono Orbe utiliza UUIDs para relacionar dados com:

* usuários;
* clientes;
* projetos;
* sites;
* servidores;
* outros recursos externos.

IDs numéricos são internos a cada banco e não são usados em exportações ou sincronizações.

Não existem foreign keys entre `webfarm_orbe`, `webfarm_core` e `webfarm_crm`.

## Migrations

| Migration                                | Resultado                            |
| ---------------------------------------- | ------------------------------------ |
| `001_create_schema_migrations.sql`       | Controle de migrations               |
| `002_create_orbe_instalacoes.sql`        | Identidade da instalação             |
| `003_create_orbe_perfis.sql`             | Perfil personalizado                 |
| `004_create_orbe_preferencias.sql`       | Preferências por contexto            |
| `005_create_orbe_categorias_atalhos.sql` | Categorias e atalhos                 |
| `006_create_orbe_conversas.sql`          | Conversas, participantes e mensagens |
| `007_create_orbe_anexos.sql`             | Arquivos e anexos de mensagens       |
| `008_create_orbe_recursos.sql`           | Recursos e vínculos com projetos     |
| `009_create_orbe_solicitacoes.sql`       | Solicitações e histórico de eventos  |
| `010_create_orbe_exportacoes.sql`        | Exportações manuais                  |
| `011_create_orbe_importacoes.sql`        | Importações e conflitos              |

## Tabelas

Uma instalação limpa possui 18 tabelas:

```text
orbe_arquivos
orbe_atalhos
orbe_categorias
orbe_conversa_participantes
orbe_conversas
orbe_exportacoes
orbe_importacao_conflitos
orbe_importacoes
orbe_instalacoes
orbe_mensagem_anexos
orbe_mensagens
orbe_perfis
orbe_preferencias
orbe_recurso_projetos
orbe_recursos
orbe_solicitacao_eventos
orbe_solicitacoes
schema_migrations
```

## Inicialização local

O Compose local utiliza:

```text
mysql:8.4
```

As migrations são montadas como somente leitura em:

```text
/docker-entrypoint-initdb.d
```

O MySQL executa esses arquivos em ordem alfabética somente quando o volume de dados está vazio.

Depois da inicialização, as migrations aplicadas podem ser consultadas com:

```sql
SELECT migration, executada_em
FROM schema_migrations
ORDER BY migration;
```

## Atualizações

O mecanismo `/docker-entrypoint-initdb.d` continua responsável pela criação de uma instalação com volume vazio. Ele não executa novos arquivos quando o volume já foi inicializado.

Bancos existentes são atualizados pelo executor incremental:

```bash
docker compose exec -T web \
  php /var/www/core/bin/migrate.php
```

O executor ordena os arquivos, impede prefixos duplicados, utiliza bloqueio exclusivo no MySQL, aplica somente migrations pendentes e registra checksums SHA-256. Registros legados sem checksum são vinculados ao conteúdo atual na primeira execução.

Uma migration publicada não deve ser modificada. Correções recebem um novo arquivo numerado. Alterações em arquivos já registrados são rejeitadas pelo checksum.

Como operações DDL do MySQL podem realizar commits implícitos, migrations devem ser validadas previamente em um banco descartável.

Antes de atualizar uma instalação com dados reais:

1. criar backup;
2. validar a migration em banco descartável;
3. verificar dependências;
4. executar com usuário autorizado;
5. conferir `schema_migrations`;
6. validar o funcionamento da aplicação.

## Instalação vazia

Uma instalação nova contém somente estrutura.

Valores esperados:

| Entidade     | Quantidade |
| ------------ | ---------: |
| Migrations   |         11 |
| Tabelas      |         18 |
| Instalações  |          0 |
| Perfis       |          0 |
| Conversas    |          0 |
| Recursos     |          0 |
| Solicitações |          0 |
| Exportações  |          0 |
| Importações  |          0 |

O primeiro usuário, cliente pessoal, instalação e perfil são criados pelo fluxo de primeiro acesso.

## Primeiro acesso local

O fluxo local deve executar uma transação:

1. gerar o UUID v4 da instalação;
2. registrar a instalação Nono Orbe;
3. criar ou obter o usuário no contrato de identidade;
4. criar o cliente pessoal;
5. criar o vínculo de administrador do cliente;
6. criar o perfil Nono Orbe;
7. criar categorias e preferências iniciais;
8. confirmar a transação.

Se qualquer operação falhar, a transação deve ser revertida.

## Contextos

Preferências, categorias e atalhos podem ser organizados por contexto:

```text
global
local
portal
admin
cliente
projeto
```

Quando não existir uma entidade específica, utiliza-se o UUID nulo:

```text
00000000-0000-0000-0000-000000000000
```

## Arquivos

O banco armazena apenas metadados.

O conteúdo físico pode ficar em:

* armazenamento local;
* armazenamento WebFarm;
* provedor compatível com S3.

Caminhos absolutos, credenciais e URLs temporárias assinadas não devem ser persistidos em `orbe_arquivos`.

## Exportação e importação

A exportação inicial é manual e identificada como `avatar`.

Ela pode transportar:

* perfil;
* preferências;
* categorias;
* atalhos;
* recursos autorizados.

Por padrão, não deve transportar:

* conversas;
* arquivos;
* credenciais;
* tokens;
* dados de terceiros.

O arquivo exportado deve possuir manifesto, versão e checksum SHA-256.

Uma importação não pode executar SQL recebido sem validação. O importador deve verificar tabelas, colunas, UUIDs, escopo, contrato, versão e comandos permitidos.

## Sincronização futura

Os registros compartilháveis possuem:

* UUID;
* UUID da instalação de origem;
* versão;
* data de criação;
* data de atualização;
* exclusão lógica quando aplicável.

Esses campos preparam o esquema para sincronização futura, mas não implementam sincronização automática.

## Seeds

A versão inicial não possui seeds SQL.

Categorias e atalhos iniciais pertencem ao perfil do usuário e são criados durante o onboarding.

Consulte:

```text
seeds/README.md
```

## Segurança

* O MySQL local é publicado somente em `127.0.0.1`.
* O arquivo `.env` não faz parte do Git.
* Migrations e seeds não contêm dados pessoais.
* Senhas diferentes são utilizadas para root e aplicação.
* O código PHP utiliza PDO MySQL.
* Consultas devem utilizar prepared statements.
* Toda consulta deve respeitar o cliente autenticado.
* Conteúdo de mensagens deve ser sanitizado antes da exibição.
* Uploads devem validar tamanho, MIME, extensão e autorização.
* Dados excluídos logicamente não devem aparecer em consultas normais.

## Validação realizada

O esquema foi validado em uma instalação descartável com MySQL 8.4.

Resultados:

```text
11 migrations executadas
18 tabelas criadas
0 instalações
0 perfis
0 conversas
0 erros de inicialização
```

O volume descartável utilizado no teste foi removido após a validação.
