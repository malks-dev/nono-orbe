<?php

declare(strict_types=1);

function escapar(string $valor): string
{
    return htmlspecialchars($valor, ENT_QUOTES, 'UTF-8');
}

/*
|--------------------------------------------------------------------------
| Atalhos iniciais
|--------------------------------------------------------------------------
| Nesta etapa, os atalhos são estáticos.
| Futuramente, serão carregados de um banco de dados.
*/

$atalhos = [
    [
        'nome' => 'Miro',
        'descricao' => 'Boards e planejamento visual',
        'url' => 'https://miro.com/app/dashboard/',
        'icone' => 'fa-solid fa-table-cells-large',
        'categoria' => 'projetos',
    ],
    [
        'nome' => 'Notion',
        'descricao' => 'Documentação e organização',
        'url' => 'https://www.notion.so/',
        'icone' => 'fa-solid fa-note-sticky',
        'categoria' => 'projetos',
    ],
    [
        'nome' => 'Trello',
        'descricao' => 'Quadros e tarefas',
        'url' => 'https://trello.com/',
        'icone' => 'fa-brands fa-trello',
        'categoria' => 'projetos',
    ],
    [
        'nome' => 'GitLab',
        'descricao' => 'Projetos e repositórios',
        'url' => 'https://gitlab.com/',
        'icone' => 'fa-brands fa-gitlab',
        'categoria' => 'projetos',
    ],

    [
        'nome' => 'Nubank',
        'descricao' => 'Conta e movimentações',
        'url' => 'https://app.nubank.com.br/',
        'icone' => 'fa-solid fa-building-columns',
        'categoria' => 'financeiro',
    ],
    [
        'nome' => 'Mercado Pago',
        'descricao' => 'Pagamentos e vendas',
        'url' => 'https://www.mercadopago.com.br/',
        'icone' => 'fa-solid fa-money-bill-transfer',
        'categoria' => 'financeiro',
    ],
    [
        'nome' => 'PayPal',
        'descricao' => 'Pagamentos internacionais',
        'url' => 'https://www.paypal.com/',
        'icone' => 'fa-brands fa-paypal',
        'categoria' => 'financeiro',
    ],
    [
        'nome' => 'Wise',
        'descricao' => 'Conta internacional',
        'url' => 'https://wise.com/',
        'icone' => 'fa-solid fa-money-check-dollar',
        'categoria' => 'financeiro',
    ],

    [
        'nome' => 'WhatsApp',
        'descricao' => 'Conversas e contatos',
        'url' => 'https://web.whatsapp.com/',
        'icone' => 'fa-brands fa-whatsapp',
        'categoria' => 'contatos',
    ],
    [
        'nome' => 'Gmail',
        'descricao' => 'E-mail',
        'url' => 'https://mail.google.com/',
        'icone' => 'fa-brands fa-google',
        'categoria' => 'contatos',
    ],
    [
        'nome' => 'Outlook',
        'descricao' => 'E-mail Microsoft',
        'url' => 'https://outlook.live.com/',
        'icone' => 'fa-brands fa-microsoft',
        'categoria' => 'contatos',
    ],
    [
        'nome' => 'iCloud',
        'descricao' => 'Serviços Apple',
        'url' => 'https://www.icloud.com/',
        'icone' => 'fa-brands fa-apple',
        'categoria' => 'contatos',
    ],

    [
        'nome' => 'LinkedIn',
        'descricao' => 'Rede profissional',
        'url' => 'https://www.linkedin.com/',
        'icone' => 'fa-brands fa-linkedin-in',
        'categoria' => 'redes',
    ],
    [
        'nome' => 'Instagram',
        'descricao' => 'Conteúdo e comunidade',
        'url' => 'https://www.instagram.com/',
        'icone' => 'fa-brands fa-instagram',
        'categoria' => 'redes',
    ],
    [
        'nome' => 'YouTube',
        'descricao' => 'Vídeos e canais',
        'url' => 'https://www.youtube.com/',
        'icone' => 'fa-brands fa-youtube',
        'categoria' => 'redes',
    ],
    [
        'nome' => 'X',
        'descricao' => 'Publicações rápidas',
        'url' => 'https://x.com/',
        'icone' => 'fa-brands fa-x-twitter',
        'categoria' => 'redes',
    ],

    [
        'nome' => 'ChatGPT',
        'descricao' => 'Assistente e agentes',
        'url' => 'https://chatgpt.com/',
        'icone' => 'fa-solid fa-wand-magic-sparkles',
        'categoria' => 'acessos',
    ],
    [
        'nome' => 'Cloudflare',
        'descricao' => 'DNS, domínios e túneis',
        'url' => 'https://dash.cloudflare.com/',
        'icone' => 'fa-brands fa-cloudflare',
        'categoria' => 'acessos',
    ],
    [
        'nome' => 'Google Drive',
        'descricao' => 'Arquivos na nuvem',
        'url' => 'https://drive.google.com/',
        'icone' => 'fa-brands fa-google-drive',
        'categoria' => 'acessos',
    ],
    [
        'nome' => 'DigitalOcean',
        'descricao' => 'Servidores e infraestrutura',
        'url' => 'https://cloud.digitalocean.com/',
        'icone' => 'fa-brands fa-digital-ocean',
        'categoria' => 'acessos',
    ],
];

$categorias = [
    'todas' => [
        'nome' => 'Todas',
        'icone' => 'fa-solid fa-shapes',
    ],
    'projetos' => [
        'nome' => 'Projetos',
        'icone' => 'fa-solid fa-diagram-project',
    ],
    'financeiro' => [
        'nome' => 'Financeiro',
        'icone' => 'fa-solid fa-wallet',
    ],
    'contatos' => [
        'nome' => 'Contatos',
        'icone' => 'fa-solid fa-address-book',
    ],
    'redes' => [
        'nome' => 'Redes sociais',
        'icone' => 'fa-solid fa-share-nodes',
    ],
    'acessos' => [
        'nome' => 'Acessos',
        'icone' => 'fa-solid fa-key',
    ],
];

$repositorio = 'https://github.com/SrMahal/nono-orbe';
$licenca = $repositorio . '/blob/main/LICENSE';
?>
<!doctype html>
<html lang="pt-BR" data-theme="graphite">
<head>
    <meta charset="utf-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1"
    >

    <meta
        name="description"
        content="ORBE — painel open source para organizar acessos e contextos digitais."
    >

    <title>ORBE — Painel de Arranque</title>

    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
    >

    <link
        rel="stylesheet"
        href="assets/css/style.css"
    >

    <script
        src="assets/js/app.js"
        defer
    ></script>
</head>

<body>
    <div class="background-orb background-orb-one"></div>
    <div class="background-orb background-orb-two"></div>

    <header class="topbar">
        <a
            class="brand"
            href="/"
            aria-label="Página inicial do ORBE"
        >
            <span class="brand-orbit" aria-hidden="true">
                <span></span>
            </span>

            <span>ORBE</span>
        </a>

        <a
            class="github-button"
            href="<?= escapar($repositorio) ?>"
            target="_blank"
            rel="noopener noreferrer"
            aria-label="Abrir o repositório oficial do ORBE no GitHub"
        >
            <i class="fa-brands fa-github"></i>
            <span>GitHub</span>
            <i class="fa-solid fa-arrow-up-right-from-square github-arrow"></i>
        </a>
    </header>

    <main class="page">
        <section class="workspace" aria-labelledby="greeting">
            <header class="welcome">
                <div>
                    <p class="eyebrow">
                        <span class="status-dot"></span>
                        Painel de arranque
                    </p>

                    <h1 id="greeting">
                        <span class="greeting-orb" aria-hidden="true">
                            <i class="fa-solid fa-earth-americas"></i>
                        </span>

                        <span id="greeting-text">Olá.</span>
                    </h1>
                </div>

                <div class="date-time" aria-label="Data e horário atuais">
                    <strong id="current-time">--:--</strong>
                    <span id="current-date">Carregando data...</span>
                </div>
            </header>

            <section class="command-panel">
                <div class="command-actions">
                    <div class="command-actions-left">
                        <a
                            class="action-button"
                            href="https://www.google.com/"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <span>Pesquisar</span>
                        </a>

                        <a
                            class="action-button"
                            href="https://chatgpt.com/"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            <i class="fa-solid fa-wand-magic-sparkles"></i>
                            <span>LLM</span>
                        </a>
                    </div>

                    <button
                        class="icon-button"
                        id="open-settings"
                        type="button"
                        aria-label="Abrir configurações"
                        title="Configurações"
                    >
                        <i class="fa-solid fa-gear"></i>
                    </button>
                </div>

                <label class="search-field" for="shortcut-search">
                    <i class="fa-solid fa-magnifying-glass"></i>

                    <input
                        id="shortcut-search"
                        type="search"
                        autocomplete="off"
                        placeholder="Busque um acesso, projeto ou contexto..."
                    >

                    <kbd>/</kbd>
                </label>
            </section>

            <nav
                class="category-navigation"
                aria-label="Categorias de atalhos"
            >
                <?php foreach ($categorias as $slug => $categoria): ?>
                    <button
                        class="category-button <?= $slug === 'todas' ? 'is-active' : '' ?>"
                        type="button"
                        data-category="<?= escapar($slug) ?>"
                        aria-pressed="<?= $slug === 'todas' ? 'true' : 'false' ?>"
                    >
                        <i class="<?= escapar($categoria['icone']) ?>"></i>
                        <span><?= escapar($categoria['nome']) ?></span>
                    </button>
                <?php endforeach; ?>
            </nav>

            <section
                class="shortcut-panel"
                aria-label="Atalhos"
            >
                <div class="shortcut-grid" id="shortcut-grid">
                    <?php foreach ($atalhos as $atalho): ?>
                        <?php
                        $busca = implode(' ', [
                            $atalho['nome'],
                            $atalho['descricao'],
                            $atalho['categoria'],
                        ]);
                        ?>

                        <a
                            class="shortcut-card"
                            href="<?= escapar($atalho['url']) ?>"
                            target="_blank"
                            rel="noopener noreferrer"
                            data-category="<?= escapar($atalho['categoria']) ?>"
                            data-search="<?= escapar($busca) ?>"
                            title="<?= escapar($atalho['descricao']) ?>"
                        >
                            <span class="shortcut-icon">
                                <i class="<?= escapar($atalho['icone']) ?>"></i>
                            </span>

                            <span class="shortcut-content">
                                <strong><?= escapar($atalho['nome']) ?></strong>
                                <small><?= escapar($atalho['descricao']) ?></small>
                            </span>

                            <i class="fa-solid fa-arrow-up-right-from-square shortcut-arrow"></i>
                        </a>
                    <?php endforeach; ?>
                </div>

                <div class="empty-state" id="empty-state" hidden>
                    <i class="fa-regular fa-compass"></i>

                    <strong>Nenhum caminho encontrado</strong>

                    <span>
                        Tente outro termo ou selecione uma categoria diferente.
                    </span>
                </div>
            </section>
        </section>
    </main>

    <footer class="footer">
        <span>ORBE Alpha 0.1.0</span>

        <a
            href="<?= escapar($licenca) ?>"
            target="_blank"
            rel="noopener noreferrer"
        >
            Licença e Termos de Uso
        </a>
    </footer>

    <dialog
        class="settings-dialog"
        id="settings-dialog"
        aria-labelledby="settings-title"
    >
        <form method="dialog">
            <header class="settings-header">
                <div>
                    <span class="settings-label">Preferências locais</span>
                    <h2 id="settings-title">Configurações</h2>
                </div>

                <button
                    class="dialog-close"
                    type="submit"
                    value="close"
                    aria-label="Fechar configurações"
                >
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </header>

            <div class="settings-content">
                <label class="settings-field">
                    <span>
                        <strong>Tema</strong>
                        <small>Aparência geral do painel</small>
                    </span>

                    <select id="theme-setting">
                        <option value="graphite">Grafite</option>
                        <option value="deep">Profundo</option>
                        <option value="light">Claro</option>
                    </select>
                </label>

                <label class="settings-field">
                    <span>
                        <strong>Abrir em nova aba</strong>
                        <small>Mantém o painel disponível</small>
                    </span>

                    <input
                        class="switch-input"
                        id="new-tab-setting"
                        type="checkbox"
                        checked
                    >

                    <span class="switch" aria-hidden="true"></span>
                </label>

                <label class="settings-field">
                    <span>
                        <strong>Mostrar descrições</strong>
                        <small>Exibe o contexto de cada atalho</small>
                    </span>

                    <input
                        class="switch-input"
                        id="descriptions-setting"
                        type="checkbox"
                        checked
                    >

                    <span class="switch" aria-hidden="true"></span>
                </label>

                <label class="settings-field">
                    <span>
                        <strong>Modo compacto</strong>
                        <small>Reduz o tamanho dos atalhos</small>
                    </span>

                    <input
                        class="switch-input"
                        id="compact-setting"
                        type="checkbox"
                    >

                    <span class="switch" aria-hidden="true"></span>
                </label>
            </div>

            <footer class="settings-footer">
                <button
                    class="secondary-button"
                    id="reset-settings"
                    type="button"
                >
                    Restaurar padrão
                </button>

                <button
                    class="primary-button"
                    type="submit"
                    value="save"
                >
                    Concluir
                </button>
            </footer>
        </form>
    </dialog>
</body>
</html>