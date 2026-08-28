# Seeds do Nono Orbe

Esta pasta contém dados públicos, globais e idempotentes necessários ao funcionamento do banco `webfarm_orbe`.

## Estado inicial

A versão inicial do Nono Orbe não possui seeds SQL.

Uma instalação nova deve iniciar com:

| Entidade     | Quantidade |
| ------------ | ---------: |
| Instalações  |          0 |
| Perfis       |          0 |
| Preferências |          0 |
| Categorias   |          0 |
| Atalhos      |          0 |
| Conversas    |          0 |
| Mensagens    |          0 |
| Arquivos     |          0 |
| Recursos     |          0 |
| Solicitações |          0 |
| Exportações  |          0 |
| Importações  |          0 |

A instalação, o primeiro usuário e seu perfil são criados pelo fluxo de primeiro acesso, e não por seeds.

## Dados proibidos

Seeds não podem criar ou armazenar:

* usuários;
* clientes;
* nomes de pessoas;
* e-mails;
* senhas ou hashes de senha;
* tokens;
* sessões;
* credenciais;
* chaves de API;
* endereços privados;
* conversas;
* arquivos pessoais;
* dados copiados de outra instalação.

## Categorias e atalhos iniciais

Categorias como Projetos, Financeiro, Contatos, Redes sociais e Acessos pertencem ao perfil de cada usuário.

Elas devem ser criadas pela aplicação durante o onboarding, usando UUIDs gerados para aquela instalação e para aquele perfil.

Esses registros não são seeds globais.

## Seeds futuros

Um seed SQL poderá ser adicionado quando existir uma tabela de referência global, sem vínculo com usuários ou clientes.

Exemplos possíveis:

* tipos públicos de recurso;
* definições de preferências aceitas;
* catálogo de capacidades;
* versões de contratos reconhecidas.

## Regras

* Cada seed deve ser idempotente.
* Seeds são executados depois de todas as migrations.
* Um seed publicado não deve ser alterado silenciosamente.
* Correções devem receber um novo arquivo numerado.
* Seeds não podem depender de IDs numéricos gerados em outra instalação.
* Seeds não podem modificar dados criados por usuários.
* Seeds não podem apagar registros.
* Dados pessoais nunca fazem parte do repositório.

## Nomenclatura futura

```text
001_seed_nome_do_catalogo.sql
002_seed_nova_referencia.sql
```

Enquanto não existirem dados globais necessários, esta pasta permanecerá sem arquivos SQL.
