'use strict';

document.addEventListener('DOMContentLoaded', () => {
    const greetingText = document.querySelector('#greeting-text');
    const currentTime = document.querySelector('#current-time');
    const currentDate = document.querySelector('#current-date');

    const searchInput = document.querySelector('#shortcut-search');
    const categoryButtons = document.querySelectorAll('.category-button');
    const shortcutCards = document.querySelectorAll('.shortcut-card');
    const shortcutGrid = document.querySelector('#shortcut-grid');
    const emptyState = document.querySelector('#empty-state');

    const openSettingsButton = document.querySelector('#open-settings');
    const settingsDialog = document.querySelector('#settings-dialog');

    const themeSetting = document.querySelector('#theme-setting');
    const newTabSetting = document.querySelector('#new-tab-setting');
    const descriptionsSetting = document.querySelector(
        '#descriptions-setting'
    );
    const compactSetting = document.querySelector('#compact-setting');
    const resetSettingsButton = document.querySelector('#reset-settings');

    const storageKey = 'orbe.settings.v1';

    const defaultSettings = {
        theme: 'graphite',
        openInNewTab: true,
        showDescriptions: true,
        compactMode: false
    };

    let activeCategory = 'todas';
    let settings = loadSettings();

    function normalizeText(value = '') {
        return value
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .toLowerCase()
            .trim();
    }

    function updateDateTime() {
        const now = new Date();
        const hour = now.getHours();

        let greeting = 'Olá.';

        if (hour >= 5 && hour < 12) {
            greeting = 'Bom dia.';
        } else if (hour >= 12 && hour < 18) {
            greeting = 'Boa tarde.';
        } else {
            greeting = 'Boa noite.';
        }

        greetingText.textContent = greeting;

        currentTime.textContent = new Intl.DateTimeFormat('pt-BR', {
            hour: '2-digit',
            minute: '2-digit'
        }).format(now);

        currentDate.textContent = new Intl.DateTimeFormat('pt-BR', {
            weekday: 'long',
            day: '2-digit',
            month: 'long'
        }).format(now);
    }

    function filterShortcuts() {
        const query = normalizeText(searchInput.value);
        let visibleCards = 0;

        shortcutCards.forEach((card) => {
            const category = card.dataset.category;
            const searchContent = normalizeText(card.dataset.search);

            const matchesCategory =
                activeCategory === 'todas' ||
                category === activeCategory;

            const matchesQuery =
                query === '' ||
                searchContent.includes(query);

            const shouldDisplay =
                matchesCategory && matchesQuery;

            card.hidden = !shouldDisplay;

            if (shouldDisplay) {
                visibleCards += 1;
            }
        });

        emptyState.hidden = visibleCards > 0;
        shortcutGrid.hidden = visibleCards === 0;
    }

    function selectCategory(button) {
        activeCategory = button.dataset.category;

        categoryButtons.forEach((categoryButton) => {
            const isActive = categoryButton === button;

            categoryButton.classList.toggle(
                'is-active',
                isActive
            );

            categoryButton.setAttribute(
                'aria-pressed',
                String(isActive)
            );
        });

        filterShortcuts();
    }

    function loadSettings() {
        try {
            const savedSettings = localStorage.getItem(storageKey);

            if (!savedSettings) {
                return { ...defaultSettings };
            }

            return {
                ...defaultSettings,
                ...JSON.parse(savedSettings)
            };
        } catch (error) {
            console.warn(
                'Não foi possível carregar as configurações do ORBE.',
                error
            );

            return { ...defaultSettings };
        }
    }

    function saveSettings() {
        try {
            localStorage.setItem(
                storageKey,
                JSON.stringify(settings)
            );
        } catch (error) {
            console.warn(
                'Não foi possível salvar as configurações do ORBE.',
                error
            );
        }
    }

    function syncSettingsForm() {
        themeSetting.value = settings.theme;
        newTabSetting.checked = settings.openInNewTab;
        descriptionsSetting.checked = settings.showDescriptions;
        compactSetting.checked = settings.compactMode;
    }

    function applySettings() {
        document.documentElement.dataset.theme =
            settings.theme;

        document.body.classList.toggle(
            'hide-descriptions',
            !settings.showDescriptions
        );

        shortcutGrid.classList.toggle(
            'is-compact',
            settings.compactMode
        );

        shortcutCards.forEach((card) => {
            card.target = settings.openInNewTab
                ? '_blank'
                : '_self';
        });

        syncSettingsForm();
    }

    function readSettingsForm() {
        settings = {
            theme: themeSetting.value,
            openInNewTab: newTabSetting.checked,
            showDescriptions: descriptionsSetting.checked,
            compactMode: compactSetting.checked
        };

        applySettings();
        saveSettings();
    }

    function resetSettings() {
        settings = { ...defaultSettings };

        applySettings();
        saveSettings();
    }

    categoryButtons.forEach((button) => {
        button.addEventListener('click', () => {
            selectCategory(button);
        });
    });

    searchInput.addEventListener('input', filterShortcuts);

    document.addEventListener('keydown', (event) => {
        const activeElement = document.activeElement;

        const isTyping =
            activeElement instanceof HTMLInputElement ||
            activeElement instanceof HTMLTextAreaElement ||
            activeElement instanceof HTMLSelectElement;

        if (event.key === '/' && !isTyping) {
            event.preventDefault();
            searchInput.focus();
        }

        if (
            event.key === 'Escape' &&
            activeElement === searchInput &&
            searchInput.value !== ''
        ) {
            searchInput.value = '';
            filterShortcuts();
        }
    });

    openSettingsButton.addEventListener('click', () => {
        syncSettingsForm();
        settingsDialog.showModal();
    });

    settingsDialog.addEventListener('click', (event) => {
        const bounds = settingsDialog.getBoundingClientRect();

        const clickedOutside =
            event.clientX < bounds.left ||
            event.clientX > bounds.right ||
            event.clientY < bounds.top ||
            event.clientY > bounds.bottom;

        if (clickedOutside) {
            settingsDialog.close();
        }
    });

    settingsDialog.addEventListener('close', () => {
        readSettingsForm();
    });

    themeSetting.addEventListener('change', readSettingsForm);
    newTabSetting.addEventListener('change', readSettingsForm);
    descriptionsSetting.addEventListener(
        'change',
        readSettingsForm
    );
    compactSetting.addEventListener('change', readSettingsForm);

    resetSettingsButton.addEventListener(
        'click',
        resetSettings
    );

    updateDateTime();
    filterShortcuts();
    applySettings();

    window.setInterval(updateDateTime, 30000);
});