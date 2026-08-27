<?php
declare(strict_types=1);

/*
|--------------------------------------------------------------------------
| ORBE — Painel de Arranque
|--------------------------------------------------------------------------
| MVP com links estáticos.
| Depois, este array será substituído por dados do banco.
*/

$contextos = [
    [
        'nome' => 'Board-projetos',
        'descricao' => 'Projetos, documentação, código e planejamento.',
        'icone' => 'fa-solid fa-diagram-project',
        'cor' => 'violeta',
        'links' => [
            [
                'nome' => 'Nono Orbe',
                'descricao' => 'Painel local do projeto',
                'url' => 'http://192.168.15.5:9000',
                'icone' => 'fa-solid fa-globe',
            ],
            [
                'nome' => 'Miro',
                'descricao' => 'Boards e mapas visuais',
                'url' => 'https://miro.com/app/dashboard/',
                'icone' => 'fa-solid fa-table-columns',
            ],
            [
                'nome' => 'GitHub — SrMahal',
                'descricao' => 'Repositórios e versões',
                'url' => 'https://github.com/SrMahal',
                'icone' => 'fa-brands fa-github',
            ],
            [
                'nome' => 'Obsidian',
                'descricao' => 'Base de conhecimento ORBE',
                'url' => 'obsidian://open?vault=Orbe',
                'icone' => 'fa-solid fa-book-open',
            ],
        ],
    ],
    [
        'nome' => 'Financeiro',
        'descricao' => 'Contas, pagamentos e visão financeira.',
        'icone' => 'fa-solid fa-wallet',
        'cor' => 'verde',
        'links' => [
            [
                'nome' => 'Nubank',
                'descricao' => 'Conta e cartões',
                'url' => 'https://app.nubank.com.br/',
                'icone' => 'fa-solid fa-building-columns',
            ],
            [
                'nome' => 'Mercado Pago',
                'descricao' => 'Pagamentos e vendas',
                'url' => 'https://www.mercadopago.com.br/',
                'icone' => 'fa-solid fa-money-bill-transfer',
            ],
            [
                'nome' => 'Planilha financeira',
                'descricao' => 'Adicionar link depois',
                'url' => '#',
                'icone' => 'fa-solid fa-file-invoice-dollar',
            ],
        ],
    ],
    [
        'nome' => 'Contato',
        'descricao' => 'Mensagens, e-mails e comunicação.',
        'icone' => 'fa-solid fa-comments',
        'cor' => 'laranja',
        'links' => [
            [
                'nome' => 'WhatsApp Web',
                'descricao' => 'Conversas e respostas rápidas',
                'url' => 'https://web.whatsapp.com/',
                'icone' => 'fa-brands fa-whatsapp',
            ],
            [
                'nome' => 'Gmail',
                'descricao' => 'E-mail principal',
                'url' => 'https://mail.google.com/',
                'icone' => 'fa-solid fa-envelope',
            ],
            [
                'nome' => 'Proton Mail',
                'descricao' => 'E-mail complementar',
                'url' => 'https://mail.proton.me/',
                'icone' => 'fa-solid fa-at',
            ],
            [
                'nome' => 'iCloud',
                'descricao' => 'Arquivos e serviços Apple',
                'url' => 'https://www.icloud.com/',
                'icone' => 'fa-brands fa-apple',
            ],
        ],
    ],
    [
        'nome' => 'Redes sociais',
        'descricao' => 'Presença pública, portfólio e conteúdo.',
        'icone' => 'fa-solid fa-share-nodes',
        'cor' => 'rosa',
        'links' => [
            [
                'nome' => 'LinkedIn',
                'descricao' => 'Perfil profissional',
                'url' => 'https://www.linkedin.com/',
                'icone' => 'fa-brands fa-linkedin-in',
            ],
            [
                'nome' => 'Instagram',
                'descricao' => 'Conteúdo e comunidade',
                'url' => 'https://www.instagram.com/',
                'icone' => 'fa-brands fa-instagram',
            ],
            [
                'nome' => 'X',
                'descricao' => 'Atualizações rápidas',
                'url' => 'https://x.com/',
                'icone' => 'fa-brands fa-x-twitter',
            ],
            [
                'nome' => 'GitHub',
                'descricao' => 'Portfólio técnico público',
                'url' => 'https://github.com/SrMahal',
                'icone' => 'fa-brands fa-github',
            ],
        ],
    ],
    [
        'nome' => 'Acessos',
        'descricao' => 'Ferramentas, nuvem e infraestrutura.',
        'icone' => 'fa-solid fa-key',
        'cor' => 'azul',
        'links' => [
            [
                'nome' => 'ChatGPT',
                'descricao' => 'Planejamento e agentes',
                'url' => 'https://chatgpt.com/',
                'icone' => 'fa-solid fa-wand-magic-sparkles',
            ],
            [
                'nome' => 'Cloudflare',
                'descricao' => 'Domínios, DNS e túneis',
                'url' => 'https://dash.cloudflare.com/',
                'icone' => 'fa-solid fa-cloud',
            ],
            [
                'nome' => 'Servidor ORBE',
                'descricao' => 'Ambiente local na rede',
                'url' => 'http://192.168.15.5:9000',
                'icone' => 'fa-solid fa-server',
            ],
            [
                'nome' => 'Adicionar acesso',
                'descricao' => 'Novo link em breve',
                'url' => '#',
                'icone' => 'fa-solid fa-plus',
            ],
        ],
    ],
];
?>
<!doctype html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ORBE — Painel de Arranque</title>

    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
    >

    <style>
        :root {
            --fundo: #090b12;
            --superficie: #111522;
            --superficie-hover: #181e30;
            --borda: rgba(255, 255, 255, .08);
            --texto: #f7f8fc;
            --texto-suave: #98a1b5;
            --violeta: #9d7cff;
            --verde: #50d89a;
            --laranja: #ffae67;
            --rosa: #fa7bc1;
            --azul: #60b8ff;
        }

        * {
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            margin: 0;
            color: var(--texto);
            background:
                radial-gradient(circle at 10% 0%, rgba(112, 75, 200, .20), transparent 28rem),
                radial-gradient(circle at 95% 100%, rgba(36, 143, 228, .13), transparent 25rem),
                var(--fundo);
            font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        .container {
            width: min(1200px, calc(100% - 40px));
            margin: 0 auto;
            padding: 56px 0 72px;
        }

        .topo {
            display: flex;
            align-items: end;
            justify-content: space-between;
            gap: 24px;
            margin-bottom: 38px;
        }

        .marca {
            display: flex;
            align-items: center;
            gap: 15px;
            color: var(--texto-suave);
            font-size: .78rem;
            font-weight: 800;
            letter-spacing: .18em;
            text-transform: uppercase;
        }

        .orbe {
            display: grid;
            width: 45px;
            height: 45px;
            place-items: center;
            color: white;
            border: 1px solid rgba(172, 140, 255, .6);
            border-radius: 50%;
            background: radial-gradient(circle at 35% 30%, #c4b1ff, #5635a7 54%, #1c1537);
            box-shadow: 0 0 35px rgba(125, 85, 223, .45);
        }

        h1 {
            max-width: 750px;
            margin: 12px 0 8px;
            font-size: clamp(2rem, 5vw, 4.2rem);
            line-height: 1.02;
            letter-spacing: -.06em;
        }

        .subtitulo {
            max-width: 610px;
            margin: 0;
            color: var(--texto-suave);
            font-size: clamp(1rem, 2vw, 1.15rem);
            line-height: 1.65;
        }

        .relogio {
            min-width: 150px;
            padding: 16px;
            color: var(--texto-suave);
            border: 1px solid var(--borda);
            border-radius: 16px;
            background: rgba(17, 21, 34, .65);
            text-align: right;
        }

        .relogio strong {
            display: block;
            margin-bottom: 3px;
            color: var(--texto);
            font-size: 1.15rem;
        }

        .busca {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 30px;
            padding: 0 18px;
            border: 1px solid var(--borda);
            border-radius: 14px;
            background: rgba(17, 21, 34, .78);
        }

        .busca i {
            color: var(--texto-suave);
        }

        .busca input {
            width: 100%;
            padding: 17px 0;
            border: 0;
            outline: 0;
            color: var(--texto);
            background: transparent;
            font: inherit;
        }

        .busca input::placeholder {
            color: #69738b;
        }

        .contextos {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 18px;
        }

        .contexto {
            overflow: hidden;
            border: 1px solid var(--borda);
            border-radius: 18px;
            background: rgba(17, 21, 34, .82);
        }

        .contexto-cabecalho {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 20px 20px 17px;
            border-bottom: 1px solid var(--borda);
        }

        .contexto-icone {
            display: grid;
            width: 40px;
            height: 40px;
            place-items: center;
            border-radius: 12px;
            color: var(--cor);
            background: color-mix(in srgb, var(--cor) 14%, transparent);
        }

        .contexto h2 {
            margin: 0;
            font-size: 1rem;
            letter-spacing: -.02em;
        }

        .contexto p {
            margin: 3px 0 0;
            color: var(--texto-suave);
            font-size: .8rem;
            line-height: 1.4;
        }

        .links {
            padding: 8px;
        }

        .link-app {
            display: flex;
            align-items: center;
            gap: 13px;
            min-height: 66px;
            padding: 10px 12px;
            border-radius: 12px;
            color: inherit;
            text-decoration: none;
            transition: background .18s ease, transform .18s ease;
        }

        .link-app:hover {
            background: var(--superficie-hover);
            transform: translateX(3px);
        }

        .link-app > i:first-child {
            display: grid;
            width: 32px;
            height: 32px;
            flex: 0 0 32px;
            place-items: center;
            border-radius: 9px;
            color: var(--cor);
            background: rgba(255, 255, 255, .05);
        }

        .link-texto {
            min-width: 0;
            flex: 1;
        }

        .link-texto strong,
        .link-texto span {
            display: block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .link-texto strong {
            font-size: .9rem;
        }

        .link-texto span {
            margin-top: 3px;
            color: var(--texto-suave);
            font-size: .76rem;
        }

        .seta {
            color: #63708a;
            font-size: .78rem;
        }

        .rodape {
            margin-top: 30px;
            color: #65708a;
            font-size: .82rem;
            text-align: center;
        }

        .oculto {
            display: none;
        }

        @media (max-width: 700px) {
            .container {
                width: min(100% - 28px, 1200px);
                padding-top: 28px;
            }

            .topo {
                align-items: start;
                flex-direction: column;
            }

            .relogio {
                width: 100%;
                text-align: left;
            }
        }
    </style>
</head>

<body>
    <main class="container">
        <header class="topo">
            <div>
                <div class="marca">
                    <span class="orbe"><i class="fa-solid fa-orbit"></i></span>
                    ORBE / Painel de Arranque
                </div>

                <h1 id="saudacao">Olá, Mahal.</h1>

                <p class="subtitulo">
                    Seus contextos de trabalho em um só lugar.
                    Menos abas abertas. Mais clareza sobre o que está construindo.
                </p>
            </div>

            <div class="relogio">
                <strong id="hora-atual">--:--</strong>
                <span id="data-atual">Carregando data...</span>
            </div>
        </header>

        <label class="busca" for="busca">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input
                id="busca"
                type="search"
                autocomplete="off"
                placeholder="Buscar um acesso, projeto ou contexto..."
            >
        </label>

        <section class="contextos" id="contextos">
            <?php foreach ($contextos as $contexto): ?>
                <article
                    class="contexto"
                    style="--cor: var(--<?= htmlspecialchars($contexto['cor']) ?>);"
                    data-contexto="<?= htmlspecialchars(mb_strtolower($contexto['nome'])) ?>"
                >
                    <header class="contexto-cabecalho">
                        <span class="contexto-icone">
                            <i class="<?= htmlspecialchars($contexto['icone']) ?>"></i>
                        </span>

                        <div>
                            <h2><?= htmlspecialchars($contexto['nome']) ?></h2>
                            <p><?= htmlspecialchars($contexto['descricao']) ?></p>
                        </div>
                    </header>

                    <div class="links">
                        <?php foreach ($contexto['links'] as $link): ?>
                            <a
                                class="link-app"
                                href="<?= htmlspecialchars($link['url']) ?>"
                                target="_blank"
                                rel="noopener noreferrer"
                                data-busca="<?= htmlspecialchars(
                                    mb_strtolower(
                                        $contexto['nome']
                                        . ' '
                                        . $link['nome']
                                        . ' '
                                        . $link['descricao']
                                    )
                                ) ?>"
                            >
                                <i class="<?= htmlspecialchars($link['icone']) ?>"></i>

                                <span class="link-texto">
                                    <strong><?= htmlspecialchars($link['nome']) ?></strong>
                                    <span><?= htmlspecialchars($link['descricao']) ?></span>
                                </span>

                                <i class="fa-solid fa-arrow-up-right-from-square seta"></i>
                            </a>
                        <?php endforeach; ?>
                    </div>
                </article>
            <?php endforeach; ?>
        </section>

        <footer class="rodape">
            ORBE v0.1.0 · Links estáticos hoje, dados personalizados amanhã.
        </footer>
    </main>

    <script>
        const saudacao = document.getElementById('saudacao');
        const horaAtual = document.getElementById('hora-atual');
        const dataAtual = document.getElementById('data-atual');
        const busca = document.getElementById('busca');

        function atualizarDataHora() {
            const agora = new Date();
            const hora = agora.getHours();

            if (hora < 12) {
                saudacao.textContent = 'Bom dia, Mahal.';
            } else if (hora < 18) {
                saudacao.textContent = 'Boa tarde, Mahal.';
            } else {
                saudacao.textContent = 'Boa noite, Mahal.';
            }

            horaAtual.textContent = agora.toLocaleTimeString('pt-BR', {
                hour: '2-digit',
                minute: '2-digit'
            });

            dataAtual.textContent = agora.toLocaleDateString('pt-BR', {
                weekday: 'long',
                day: '2-digit',
                month: 'long'
            });
        }

        busca.addEventListener('input', () => {
            const termo = busca.value.trim().toLowerCase();

            document.querySelectorAll('.contexto').forEach((contexto) => {
                const nomeContexto = contexto.dataset.contexto;
                let possuiLinkVisivel = false;

                contexto.querySelectorAll('.link-app').forEach((link) => {
                    const corresponde = link.dataset.busca.includes(termo)
                        || nomeContexto.includes(termo);

                    link.classList.toggle('oculto', !corresponde);

                    if (corresponde) {
                        possuiLinkVisivel = true;
                    }
                });

                contexto.classList.toggle('oculto', !possuiLinkVisivel);
            });
        });

        atualizarDataHora();
        setInterval(atualizarDataHora, 30000);
    </script>
</body>
</html>