return {
  'williamboman/mason.nvim',
  lazy = false,
  cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
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
      pip = {
        upgrade_pip = true,
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
        'cssls',
        'sqlls',
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
        'shellharden', -- needs cargo installed
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

    local servers = mason_lspconfig.get_installed_servers()
    for _, server_name in ipairs(servers) do
      lspconfig[server_name].setup({})
    end
  end,
}
