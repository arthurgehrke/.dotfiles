return {
  'williamboman/mason.nvim',
  lazy = false,
  cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
  build = ':MasonUpdate',
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
        'yamlls', -- yaml
        'tsserver',
        'jqls',
        'lua_ls',
        'pylsp',
        'jsonls',
      },
      automatic_installation = true, -- not the same as ensure_installed
      auto_update = true,
    })
    mason_tool_installer.setup({
      automatic_installation = true, -- not the same as ensure_installed
      auto_update = true,
      ensure_installed = {
        { 'bash-language-server', auto_update = true },
        'tsserver',
        'stylua',
        'cssls',
        'lua-language-server',
        'prettierd', -- yaml format
        'selene', -- lua lint
        'shellcheck', -- bash, sh, zsh lint
        'shfmt', -- bash, sh, zsh format
        'prettier',
        'eslint',
        'stylelint',
        'sqlls',
        'isort', -- python formatter
        'pylint', -- python linter
        'eslint_d', -- js linter
        'jq',
      },
    })
  end,
}
