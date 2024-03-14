-- enable mason
require('mason').setup({
  PATH = 'prepend',
})

require('mason-lspconfig').setup({
  automatic_installation = true,
  auto_update = true,
  ensure_installed = {
    'tsserver',
    'html',
    'cssls',
    'lua_ls',
    'eslint',
  },
})

require('mason-tool-installer').setup({
  automatic_installation = true,
  ensure_installed = {
    'lua-language-server',
    'yaml-language-server',
    'prettierd',
    'pyright',
    'json-lsp',
    'eslint_d',
    'isort',
    'stylua',
    'shellcheck',
    'shfmt',
    'sql-formatter',
    'black',
    'shfmt',
    'jq',
    'fixjson',
    'eslint',
    'bashls',
  },
})

local dap_servers = {
  'js-debug-adapter',
  'node-debug2-adapter',
  'js',
  'node2',
  'chrome',
}

require('mason-nvim-dap').setup({
  ensure_installed = dap_servers,
  automatic_installation = true,
  automatic_setup = true,
  auto_update = true,
})
