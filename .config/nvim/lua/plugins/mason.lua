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
        ensure_installed = {
          'black',
        },
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })
    mason_lspconfig.setup({
      ensure_installed = {
        'html',
        'bashls', -- bash, sh, zsh
        'pyright', -- python
        'rust_analyzer', -- rust lacks linter
        'tsserver',
        'jqls',
        'lua_ls',
        'pylsp',
        'jsonls',
        'eslint',
      },
      automatic_installation = true, -- not the same as ensure_installed
      auto_update = true,
    })
    mason_tool_installer.setup({
      automatic_installation = true, -- not the same as ensure_installed
      auto_update = true,
      start_delay = 3000,
      debounce_hours = 5,
      run_on_start = true,
      ensure_installed = {
        { 'typescript-language-server' },
        'black',
        'bash-language-server',
        'stylua',
        'cssls',
        'prettierd', -- yaml format
        'selene', -- lua lint
        'shellcheck', -- bash, sh, zsh lint
        'shfmt', -- bash, sh, zsh format
        'prettier',
        'stylelint',
        'sqlls',
        'isort', -- python formatter
        'pylint', -- python linter
        'eslint_d', -- js linter
        'jq',
        'yamlfix',
        'yamllint',
        'nginx-language-server',
        'htmlbeautifier',
        'htmlhint',
        'beautysh',
        'gitlint',
      },
    })
  end,
}
