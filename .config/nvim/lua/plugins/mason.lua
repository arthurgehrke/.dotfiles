return {
  'williamboman/mason.nvim',
  lazy = false,
  cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')

    mason.setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        'bashls', -- Bash, sh, zsh
        'pyright', -- Python
        'rust_analyzer', -- Rust
        'ts_ls', -- TypeScript
        'jsonls', -- JSON
        'eslint', -- JavaScript Linter
        'html', -- HTML
        'lua_ls', -- Lua
        'jqls', -- jq (JSON)
        'yamlls',
        'marksman'
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'shfmt',
        'black', -- Python formatter
        'bash-language-server', -- Bash LSP
        'stylua', -- Lua formatter
        'prettierd', -- Prettier daemon
        'selene', -- Lua linter
        'shellcheck', -- Bash linter
        'shellharden', 
        'shfmt', -- Bash formatter
        'prettier', -- General formatter
        'stylelint', -- CSS linter
        'sqlls', -- SQL LSP
        'isort', -- Python import sorter
        'pylint', -- Python linter
        'eslint_d', -- JavaScript linter daemon
        'jq', -- JSON processor
        'yamlfix', -- YAML fixer
        'yamllint', -- YAML linter
        'nginx-language-server', -- Nginx LSP
        'htmlbeautifier', -- HTML beautifier
        'htmlhint', -- HTML linter
        'gitlint', -- Git commit linter
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- Delay for installation at start
      debounce_hours = 5, -- Delay before running updates
    })
  end,
}
