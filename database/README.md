# Banco de dados do Nono Orbe

O Nono Orbe utiliza o banco lógico `webfarm_orbe` para armazenar informações da experiência personalizada do usuário.

Identidade, autenticação, clientes e permissões pertencem ao contrato `webfarm_core`.

## Responsabilidades

| Banco          | Responsabilidade                                                     |
| -------------- | -------------------------------------------------------------------- |
| `webfarm_core` | Usuários, autenticação, clientes, vínculos e permissões              |
| `webfarm_orbe` | Perfis, preferências, atalhos e recursos personalizados do Nono Orbe |
| `webfarm_crm`  | Projetos comerciais, tarefas, leads e cobranças do WebFarm           |

O Nono Orbe é responsável apenas pelas migrations de `webfarm_orbe`.

## Estrutura

```text
database/
├── contracts/
└── webfarm_orbe/
    ├── migrations/
    └── seeds/
```

### `contracts`

Documenta os contratos externos utilizados pelo Nono Orbe, especialmente os campos e identificadores esperados de `webfarm_core`.

Esta pasta não deve conter cópias modificadas das migrations oficiais do WebFarm.

### `migrations`

Contém alterações versionadas do esquema `webfarm_orbe`.

### `seeds`

Contém apenas dados iniciais necessários ao funcionamento do Nono Orbe.

Seeds não devem criar:

* usuários;
* senhas;
* clientes demonstrativos;
* tokens;
* credenciais;
* dados pessoais fictícios em produção.

## Regras das migrations

* Os arquivos são executados em ordem alfabética.
* Cada arquivo recebe prefixo numérico com três dígitos.
* Uma migration publicada nunca deve ser editada.
* Uma correção deve ser implementada em uma nova migration.
* Cada migration registra sua execução em `schema_migrations`.
* Datas internas utilizam UTC.
* Registros compartilháveis utilizam UUID v4.
* Relações com outros bancos utilizam UUID, sem foreign key entre bancos.
* Nomes de tabelas e colunas utilizam `snake_case`.
* Tabelas utilizam `InnoDB` e `utf8mb4`.

## Compatibilidade

A distribuição Local instala um contrato compatível de `webfarm_core` antes de instalar `webfarm_orbe`.

A integração WebFarm utiliza o `webfarm_core` fornecido pela própria instalação WebFarm.

Nos dois ambientes, as migrations de `webfarm_orbe` devem ser idênticas e possuir a mesma versão.
