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
├── src/
│   ├── Config/
│   ├── Database/
│   ├── Domain/
│   └── Support/
└── views/
    ├── components/
    └── layouts/
```

### `src/Config`

Carregamento e validação das configurações utilizadas pelo Core.

### `src/Database`

Conexão, execução de migrations e acesso ao banco `webfarm_orbe`.

### `src/Domain`

Entidades, regras e serviços próprios do Nono Orbe.

### `src/Support`

Funções auxiliares que não pertencem diretamente a uma regra de domínio.

### `views/components`

Componentes reutilizáveis da interface.

### `views/layouts`

Layouts compartilhados pelas distribuições Local e WebFarm.

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

## Evolução

O Core deve permanecer independente da forma de instalação. Funcionalidades específicas de localhost ou WebFarm devem ser implementadas em adaptadores externos ao Core.
