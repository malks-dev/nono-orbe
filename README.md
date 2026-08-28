<p align="center">
  <img
    src="app/public/assets/image/compartilhamento/nono-orbe-social-preview-1280x640.png"
    alt="Banner do projeto Nono Orbe"
    width="100%"
  >
</p>

# Nono Orbe

Sistema-base do ecossistema **ORBE**: um ambiente pessoal, aberto e programável para organizar a vida, construir projetos e publicar novas experiências na internet.

Este repositório evolui junto com a própria documentação. Cada etapa técnica também se transforma em registro, aprendizado e conteúdo público.

## Estado atual

* Última versão lançada: `0.1.0`
* Próxima versão: em desenvolvimento
* Etapa: fundação do Nono Orbe Core
* Aplicação: PHP 8.3 + Apache
* Banco: MySQL 8.4
* Porta web padrão: `9000`
* Porta MySQL local: `9001`
* Acesso no servidor: `http://localhost:9000`
* Acesso na rede local: `http://IP-DO-SERVIDOR:9000`

A estrutura do banco já está implementada e validada. A aplicação visual ainda não utiliza essas tabelas; conexão PDO, primeiro acesso e autenticação fazem parte das próximas etapas.

## Visão da arquitetura

O Nono Orbe está sendo preparado para dois ambientes:

| Ambiente                | Objetivo                                                                       |
| ----------------------- | ------------------------------------------------------------------------------ |
| **Nono Orbe Local**     | Permitir que a pessoa construa e personalize seu sistema no próprio computador |
| **Nono Orbe + WebFarm** | Oferecer a mesma experiência em um servidor, com projetos, serviços e suporte  |

O Core reúne componentes e regras compartilhados pelos dois ambientes.

## Bancos e responsabilidades

| Banco          | Responsabilidade                                              |
| -------------- | ------------------------------------------------------------- |
| `webfarm_core` | Identidade, autenticação, clientes e permissões               |
| `webfarm_crm`  | Projetos comerciais, tarefas, leads e cobranças               |
| `webfarm_orbe` | Perfil, preferências, comunicação e experiência personalizada |

O Nono Orbe Local utiliza um contrato compatível de identidade. Na integração com WebFarm, a identidade será fornecida pelo próprio `webfarm_core`.

## Início rápido

Crie a configuração local:

```bash
cp .env.example .env
```

Gere duas senhas diferentes:

```bash
openssl rand -hex 32
openssl rand -hex 32
```

Abra o arquivo privado:

```bash
nano .env
```

Substitua:

```text
TROQUE_A_SENHA_DO_USUARIO
TROQUE_A_SENHA_ROOT
```

Valide e inicie:

```bash
docker compose config --quiet
docker compose up -d --build --wait
docker compose ps
```

No próprio servidor, acesse:

```text
http://localhost:9000
```

Em outro dispositivo da mesma rede, use o IP do servidor:

```text
http://IP-DO-SERVIDOR:9000
```

O MySQL é publicado somente no próprio computador:

```text
127.0.0.1:9001
```

## Serviços

| Serviço | Imagem           | Função                               |
| ------- | ---------------- | ------------------------------------ |
| `web`   | `php:8.3-apache` | Aplicação web do Nono Orbe           |
| `mysql` | `mysql:8.4`      | Persistência do banco `webfarm_orbe` |

O serviço web utiliza PDO MySQL e aguarda o banco ficar saudável antes de iniciar.

## Banco `webfarm_orbe`

A fundação atual possui:

```text
11 migrations
18 tabelas
0 usuários incluídos
0 perfis incluídos
0 dados pessoais incluídos
```

As migrations são executadas automaticamente apenas durante a primeira criação de um volume MySQL vazio.

Consulte a documentação completa:

* [Visão geral do banco](database/README.md)
* [Contrato de identidade](database/contracts/README.md)
* [Esquema `webfarm_orbe`](database/webfarm_orbe/README.md)
* [Política de seeds](database/webfarm_orbe/seeds/README.md)

## Core

```text
core/
├── src/
│   ├── Config/
│   ├── Database/
│   ├── Domain/
│   └── Support/
└── views/
    ├── components/
    └── layouts/
```

O Core não controla Docker, credenciais, provedores externos ou regras exclusivas do ambiente WebFarm.

Consulte:

* [Nono Orbe Core](core/README.md)

## Processos documentados

### Processo 001 — O nascimento do Nono Orbe

Criação da primeira aplicação PHP em Docker, acesso pela porta `9000` e fundação conceitual do projeto.

➡️ [Ler o Processo 001](docs/processo/001.md)

### Processo 002 — A fundação do Nono Orbe Core

Criação do Core, contrato de identidade, MySQL 8.4, migrations, segurança, exportação, importação e validação do banco.

➡️ [Ler o Processo 002](docs/processo/002.md)

## Comandos úteis

```bash
# Validar o Compose sem imprimir variáveis resolvidas
docker compose config --quiet

# Construir e iniciar
docker compose up -d --build --wait

# Ver o estado
docker compose ps

# Ver os logs da aplicação
docker compose logs -f web

# Ver os logs do MySQL
docker compose logs -f mysql

# Verificar as migrations
docker compose exec -T mysql sh -lc \
  'mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" \
  -e "SELECT migration FROM schema_migrations ORDER BY migration;"'

# Parar os serviços sem remover os dados
docker compose down
```

Não utilize:

```bash
docker compose down -v
```

A opção `-v` remove o volume do MySQL e apaga os dados locais.

## Cloudflared

Um túnel existente pode encaminhar requisições para:

```yaml
service: http://localhost:9000
```

Credenciais, tokens, certificados e a configuração autenticada do Cloudflared não fazem parte deste repositório.

O MySQL não deve ser publicado pelo túnel.

## Estrutura

```text
orbe/
├── app/
│   └── public/
├── core/
│   ├── src/
│   └── views/
├── database/
│   ├── contracts/
│   └── webfarm_orbe/
│       ├── migrations/
│       └── seeds/
├── docker/
│   └── php/
├── docs/
│   ├── architecture/
│   ├── processo/
│   ├── versions/
│   ├── CHANGELOG.md
│   └── ROADMAP.md
├── storage/
├── .env.example
├── .gitignore
├── compose.yaml
└── README.md
```

## Dados locais e segurança

Não fazem parte do Git:

* `.env`;
* volumes do MySQL;
* uploads;
* conversas;
* exportações;
* importações;
* backups;
* chaves privadas;
* tokens;
* credenciais;
* dados pessoais.

Migrations e seeds públicos devem produzir uma instalação vazia.

## Documentação viva

Cada processo deve atualizar:

1. `docs/processo/NNN.md`, contando a evolução em ordem cronológica;
2. `docs/CHANGELOG.md`, registrando mudanças objetivas;
3. `docs/ROADMAP.md`, quando prioridades ou decisões mudarem;
4. `docs/versions/vX.Y.Z.md`, durante a preparação e lançamento de uma versão;
5. o README, quando instalação ou arquitetura mudarem;
6. a versão exibida pela aplicação quando houver um novo lançamento.

## Roadmap

As próximas etapas incluem:

* configuração central;
* conexão PDO;
* endpoint `/health`;
* executor incremental de migrations;
* primeiro usuário local;
* perfil dinâmico;
* categorias e atalhos;
* comunicação;
* exportação e importação;
* integração com WebFarm.

Consulte o [roadmap completo](docs/ROADMAP.md).

## Licença

O ORBE é um projeto de código-fonte disponível sob a [Licença Comunitária Individual ORBE v0.1](LICENSE).

A licença permite baixar, instalar, utilizar individualmente e modificar o projeto. Redistribuições e versões comerciais modificadas devem respeitar as condições de licenciamento individual e não podem utilizar o nome, os logos ou a identidade oficial do ORBE.

Consulte o arquivo [`LICENSE`](LICENSE) antes de utilizar, modificar ou redistribuir o projeto.
