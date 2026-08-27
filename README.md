# Nono Orbe

Sistema-base do ecossistema **ORBE**: um ambiente pessoal, aberto e programável para organizar a vida, construir projetos e publicar novas experiências na internet.

Este repositório evolui junto com a própria documentação. Cada etapa técnica também se transforma em registro, aprendizado e conteúdo público.

## Estado atual

- Versão: `0.1.0`
- Etapa: primeiro contêiner
- Serviço: PHP 8.3 + Apache
- Porta padrão: `9000`
- Acesso no servidor: `http://localhost:9000`
- Acesso na rede local: `http://IP-DO-SERVIDOR:9000`

## Início rápido

```bash
cp .env.example .env
docker compose up -d --build
docker compose ps
```

No próprio servidor, abra `http://localhost:9000`. Em outro dispositivo conectado à mesma rede, use o IP do servidor, por exemplo `http://192.168.15.5:9000`.

## Primeiro capítulo

O nascimento conceitual e técnico do projeto está documentado em:

➡️ **[Processo 001 — O nascimento do Nono Orbe](docs/processo/001.md)**

Esse capítulo apresenta a ideia do ORBE, as primeiras jornadas do ecossistema, a organização do repositório, a criação do contêiner PHP, o acesso pela rede e os comandos de validação.

## Comandos úteis

```bash
# Validar o Compose
docker compose config

# Construir e iniciar
docker compose up -d --build

# Ver o estado e os registros
docker compose ps
docker compose logs -f web

# Verificar a saúde
docker inspect --format='{{.State.Health.Status}}' nono-orbe-web

# Parar o projeto
docker compose down
```

## Cloudflared

O túnel já existente pode encaminhar requisições para:

```yaml
service: http://localhost:9000
```

Credenciais, tokens, certificados e a configuração autenticada do Cloudflared não fazem parte deste repositório.

## Estrutura

```text
orbe/
├── app/
│   └── public/
│       └── index.php
├── docker/
│   └── php/
│       └── Dockerfile
├── docs/
│   ├── architecture/
│   │   └── repository.md
│   ├── processo/
│   │   └── 001.md
│   ├── versions/
│   │   └── v0.1.0.md
│   ├── CHANGELOG.md
│   └── ROADMAP.md
├── storage/
│   ├── cache/
│   ├── logs/
│   ├── sessions/
│   └── uploads/
├── .env.example
├── .gitignore
├── compose.yaml
└── README.md
```

Consulte também a [organização do repositório](docs/architecture/repository.md).

## Documentação viva

Cada etapa deve atualizar, no mínimo:

1. `docs/processo/NNN.md`, contando o processo em ordem cronológica;
2. `docs/CHANGELOG.md`, registrando a mudança objetiva;
3. `docs/versions/vX.Y.Z.md`, documentando decisões e validações;
4. `docs/ROADMAP.md`, quando a próxima etapa mudar;
5. a versão exibida pela aplicação.

## Licença

A licença open source será definida antes da primeira publicação estável. Até essa decisão, não presuma permissão de redistribuição.
