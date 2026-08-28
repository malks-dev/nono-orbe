# Contratos externos do Nono Orbe

Esta pasta documenta os contratos externos utilizados pelo Nono Orbe Core.

Um contrato descreve quais dados e comportamentos o Nono Orbe espera de outro sistema, sem copiar nem assumir a propriedade das migrations desse sistema.

## Contrato atual

```text
Nome: webfarm-core-identity
Versão: 1.0
Responsável: WebFarm Server
Consumidor: Nono Orbe Core
```

O contrato `webfarm-core-identity/1.0` fornece identidade, autenticação, clientes, vínculos e permissões para o Nono Orbe.

## Princípios

* O WebFarm é responsável pelo esquema completo de `webfarm_core`.
* O Nono Orbe é responsável pelo esquema `webfarm_orbe`.
* O Nono Orbe não altera diretamente migrations do WebFarm.
* IDs numéricos são internos ao banco de origem.
* Integrações, exportações e sincronizações utilizam UUID.
* Senhas, sessões e tokens nunca fazem parte de exportações do Nono Orbe.
* O Nono Orbe deve continuar funcionando sem conexão com uma instalação remota.
* A autorização sempre deve ser validada no ambiente que executa a aplicação.

## Identidade do usuário

O Nono Orbe espera uma entidade equivalente a `webfarm_core.usuarios`.

### Campos necessários

| Campo                 | Finalidade                                         |
| --------------------- | -------------------------------------------------- |
| `id`                  | Relacionamento interno no mesmo banco              |
| `uuid`                | Identidade estável para integração e sincronização |
| `nome`                | Nome apresentado na experiência do usuário         |
| `email`               | Identificação e comunicação com o usuário          |
| `senha_hash`          | Autenticação local, sem exposição ao Nono Orbe     |
| `tipo_usuario`        | Contexto principal do usuário                      |
| `ativo`               | Controle de acesso à conta                         |
| `email_verificado_em` | Estado da verificação do e-mail                    |
| `perfil_completo_em`  | Estado do primeiro acesso                          |
| `criado_em`           | Auditoria de criação                               |
| `atualizado_em`       | Auditoria de alteração                             |

### Regras

* `uuid` deve ser um UUID v4.
* `email` deve ser normalizado antes de ser persistido.
* `email` deve ser único dentro da instalação.
* `senha_hash` deve ser criado por uma função segura de hash de senha.
* O Nono Orbe nunca consulta ou exporta `senha_hash`.
* Usuários inativos não podem iniciar novas sessões.
* Nível e pontos não concedem permissões.

## Cliente

O Nono Orbe espera uma entidade equivalente a `webfarm_core.clientes`.

### Campos necessários

| Campo                   | Finalidade                            |
| ----------------------- | ------------------------------------- |
| `id`                    | Relacionamento interno no mesmo banco |
| `uuid`                  | Identidade estável do cliente         |
| `slug`                  | Identificador legível e único         |
| `nome_razao_social`     | Nome principal do cliente             |
| `nome_fantasia`         | Nome de exibição opcional             |
| `email_contato`         | E-mail principal de contato           |
| `status`                | Estado operacional do cliente         |
| `criado_por_usuario_id` | Usuário responsável pela criação      |
| `criado_em`             | Auditoria de criação                  |
| `atualizado_em`         | Auditoria de alteração                |

## Vínculo entre cliente e usuário

O Nono Orbe espera uma entidade equivalente a `webfarm_core.cliente_usuarios`.

### Campos necessários

| Campo           | Finalidade                         |
| --------------- | ---------------------------------- |
| `cliente_id`    | Cliente do vínculo                 |
| `usuario_id`    | Usuário do vínculo                 |
| `papel`         | Papel do usuário dentro do cliente |
| `ativo`         | Estado do vínculo                  |
| `criado_em`     | Auditoria de criação               |
| `atualizado_em` | Auditoria de alteração             |

Os papéis reconhecidos pelo contrato `1.0` são:

* `administrador`;
* `gestor`;
* `operador`.

A interface pode ocultar ações, mas a autorização deve ser validada novamente no servidor.

## Primeiro usuário local

Uma instalação local nova começa sem usuários.

Durante o primeiro acesso, a distribuição Nono Orbe Local deve executar uma transação com esta sequência:

1. Criar um usuário com UUID v4.
2. Definir `tipo_usuario` como `cliente`.
3. Manter `email_verificado_em` vazio enquanto não houver verificação.
4. Criar um cliente pessoal com UUID v4.
5. Registrar o próprio usuário como responsável pela criação do cliente.
6. Criar o vínculo entre cliente e usuário.
7. Definir o papel do vínculo como `administrador`.
8. Criar o perfil correspondente em `webfarm_orbe`.
9. Confirmar a transação somente se todas as operações forem concluídas.

Se qualquer operação falhar, toda a criação deve ser revertida.

O primeiro usuário local não é um administrador da equipe WebFarm. Ele é o administrador de seu cliente pessoal.

## Contexto autenticado

Após o login, o adaptador de identidade deve fornecer ao Nono Orbe:

```text
usuario_uuid
cliente_uuid
papel_cliente
tipo_usuario
nome
email
email_verificado
```

Dados numéricos internos, como `usuarios.id` e `clientes.id`, não devem ser usados como identificadores de sincronização.

## Exportação

Uma exportação de perfil pode incluir:

* UUID do usuário;
* UUID do cliente;
* nome de exibição;
* perfil Nono Orbe;
* preferências;
* atalhos;
* categorias;
* versão do contrato;
* UUID da instalação de origem.

Uma exportação não pode incluir:

* hash de senha;
* tokens de autenticação;
* tokens de reset;
* sessões;
* credenciais de APIs;
* credenciais de bancos;
* dados de outros usuários sem autorização.

## Compatibilidade

Uma instalação é compatível com `webfarm-core-identity/1.0` quando:

* oferece as entidades e os campos obrigatórios deste documento;
* preserva UUIDs durante importação e exportação;
* reconhece os papéis definidos no contrato;
* fornece um contexto autenticado equivalente;
* impede acesso a dados fora do cliente autorizado.

Campos adicionais são permitidos e não quebram o contrato.

Remoção de campos obrigatórios, alteração de significado ou mudança incompatível de tipos exige uma nova versão principal do contrato.
