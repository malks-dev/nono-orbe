# Nono Orbe Core

O Nono Orbe Core contém os componentes reutilizáveis da experiência Nono Orbe.

Ele deve funcionar em dois contextos:

* instalação local e independente;
* integração com uma instalação WebFarm.

## Responsabilidades

O Core é responsável por:

* regras de domínio do Nono Orbe;
* configuração comum da aplicação;
* acesso aos dados pertencentes ao Nono Orbe;
* componentes e layouts compartilhados;
* contratos utilizados pelas distribuições Local e WebFarm;
* compatibilidade com importação e exportação de dados.

## Estrutura

```text
core/
├── bootstrap.php
├── bin/
│   └── migrate.php
├── src/
│   ├── Config/
│   ├── Database/
│   ├── Domain/
│   └── Support/
└── views/
    ├── components/
    └── layouts/
```

### `bootstrap.php`

Registra o autoload das classes sob o namespace `NonoOrbe\Core`.

### `bin/migrate.php`

Executa migrations pendentes em bancos já inicializados.

O comando utiliza bloqueio exclusivo no MySQL, registra checksums SHA-256 e rejeita alterações em migrations previamente aplicadas.

### `src/Config`

Carregamento e validação das configurações utilizadas pelo Core.

As classes `Environment`, `AppConfig` e `DatabaseConfig` validam ambiente, debug, timezone e conexão sem expor senhas ou outros valores sensíveis.

### `src/Database`

Conexão PDO, execução incremental de migrations e acesso ao banco `webfarm_orbe`.

A conexão utiliza:

* charset `utf8mb4`;
* prepared statements nativos;
* exceções PDO;
* sessão do banco em UTC;
* conexão não persistente;
* reutilização da mesma instância PDO durante a execução.

### `src/Domain`

Entidades, regras e serviços próprios do Nono Orbe.

### `src/Support`

Serviços auxiliares que não pertencem diretamente a uma regra de domínio.

O `HealthCheck` verifica o estado da aplicação e do banco e informa a quantidade de migrations registradas sem retornar credenciais, DSN ou detalhes internos de exceções.

### `views/components`

Componentes reutilizáveis da interface.

### `views/layouts`

Layouts compartilhados pelas distribuições Local e WebFarm.

## Configuração

A configuração da aplicação é carregada por variáveis de ambiente.

As principais variáveis utilizadas pelo Core são:

```dotenv
APP_ENV=development
APP_DEBUG=false
TZ=America/Sao_Paulo

DB_HOST=mysql
DB_PORT=3306
DB_NAME=webfarm_orbe
DB_USER=nono_orbe
DB_PASSWORD=senha_privada
```

O nome lógico `webfarm_orbe` é canônico e não é configurável na distribuição Local. Os demais valores são fornecidos pela distribuição Local ou pela infraestrutura WebFarm.

O Core não carrega diretamente arquivos `.env` e não mantém credenciais no repositório.

## Conexão com o banco

A classe `DatabaseConfig` monta o DSN sem incluir a senha.

A classe `Connection` abre a conexão PDO e configura:

```text
charset=utf8mb4
prepared statements nativos
tratamento de erros por exceções
fetch associativo por padrão
sessão MySQL em UTC
timeout de conexão
conexão não persistente
```

Erros de conexão são convertidos em uma mensagem segura, sem revelar usuário, senha, host completo ou DSN.

## Migrations

Em instalações com um volume MySQL vazio, os arquivos SQL são executados pelo mecanismo:

```text
/docker-entrypoint-initdb.d
```

Esse mecanismo funciona somente durante a primeira inicialização do volume.

Para aplicar migrations pendentes em um banco já inicializado, execute:

```bash
docker compose exec -T web \
  php /var/www/core/bin/migrate.php
```

O executor incremental:

* ordena as migrations pelo nome;
* valida o padrão dos nomes;
* impede prefixos numéricos duplicados;
* obtém um bloqueio exclusivo no MySQL;
* aplica somente migrations pendentes;
* registra checksums SHA-256;
* preenche checksums ausentes em registros legados;
* rejeita alterações em migrations já aplicadas;
* rejeita registros sem arquivo correspondente;
* pode ser executado repetidamente sem reaplicar a estrutura.

Uma migration publicada não deve ser modificada. Qualquer correção deve ser adicionada em um novo arquivo numerado.

Como operações DDL do MySQL podem realizar commits implícitos, toda migration deve ser validada previamente em um banco descartável.

## Verificação de saúde

O endpoint público de saúde está disponível em:

```text
http://127.0.0.1:9000/health/
http://IP_DO_SERVIDOR:9000/health/
```

Quando aplicação e banco estão disponíveis, o endpoint retorna HTTP `200`:

```json
{
    "status": "ok",
    "application": {
        "status": "ok",
        "environment": "development"
    },
    "database": {
        "status": "ok",
        "migrations": 11
    }
}
```

Quando o MySQL está indisponível, o endpoint retorna HTTP `503`:

```json
{
    "status": "error",
    "application": {
        "status": "ok",
        "environment": "development"
    },
    "database": {
        "status": "unavailable"
    }
}
```

A resposta não expõe senhas, credenciais, DSN, mensagens internas ou detalhes de exceções.

## Limites do Core

O Core não deve:

* iniciar contêineres;
* depender de um domínio ou URL específica;
* definir credenciais de infraestrutura;
* substituir a autorização do WebFarm;
* controlar diretamente Portal, Admin ou Host;
* armazenar senhas, tokens ou credenciais externas;
* conter regras exclusivas de um provedor de e-mail ou pagamento.

Essas responsabilidades pertencem à distribuição ou integração que estiver utilizando o Core.

## Identidade

O Nono Orbe utiliza a identidade definida pelo contrato do `webfarm_core`.

As informações personalizadas do usuário são relacionadas por UUID. O Nono Orbe não cria um modelo de autenticação incompatível com o WebFarm.

A distribuição Local deverá fornecer uma identidade compatível com o mesmo contrato, permitindo a futura movimentação de dados entre Local e WebFarm.

## Segurança

O Core segue estas regras:

* credenciais são fornecidas somente por variáveis de ambiente;
* senhas não aparecem em resumos de configuração;
* erros públicos não apresentam detalhes internos;
* o banco trabalha com prepared statements nativos;
* migrations aplicadas são protegidas por checksum;
* execuções concorrentes de migrations são impedidas;
* migrations e seeds não incluem usuários ou dados pessoais;
* relações externas utilizam UUIDs em vez de IDs internos.

## Validação realizada

A implementação atual foi validada com:

```text
PHP 8.3
Apache 2.4
MySQL 8.4
11 migrations
18 tabelas
```

Também foram confirmados:

* autoload das classes do Core;
* leitura e validação das variáveis de ambiente;
* timezone da aplicação em `America/Sao_Paulo`;
* sessão do banco em UTC;
* reutilização da conexão PDO;
* endpoint saudável com HTTP `200`;
* indisponibilidade do banco com HTTP `503`;
* recuperação automática após o retorno do MySQL;
* acesso pela rede local na porta `9000`;
* preenchimento de 11 checksums legados;
* idempotência do executor de migrations;
* rejeição de migration aplicada que tenha sido alterada;
* aplicação e registro de uma migration temporária pendente.

## Evolução

O Core deve permanecer independente da forma de instalação.

Funcionalidades específicas de localhost ou WebFarm devem ser implementadas em adaptadores externos ao Core.

As próximas etapas incluem:

* tratamento centralizado de erros;
* proteção adicional para ambiente de produção;
* integração do Core com a ORBE Home;
* estado visual seguro quando o banco estiver indisponível;
* adaptador de identidade da distribuição Local;
* fluxo de primeiro acesso;
* criação do primeiro usuário, cliente pessoal e perfil.

