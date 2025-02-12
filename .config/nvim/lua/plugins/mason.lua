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
        'bashls',
        'pyright',
        'pylsp',
        'rust_analyzer',
        'ts_ls',
        'jsonls',
        'eslint',
        'html',
        'lua_ls',
        'jqls',
        'yamlls',
        'rust_analyzer',
        'gopls',
        'cssls',
        'dockerls',
        'julials',
        'nginx_language_server',
        'ruby_lsp',
        'sqlls',
        'gitlab_ci_ls'
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'shfmt',
        'black',
        'stylua',
        'prettierd',
        'selene',
        'shellcheck',
        'shellharden',
        'eslint_d',
        'prettier',
        'stylelint',
        'pylint',
        'jq',
        'yamlfix',
        'yamllint',
        'htmlbeautifier',
        'textlint',
        'sqlfluff',
      },
    })
  end,
}
