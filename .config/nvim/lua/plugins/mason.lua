-- enable mason
require('mason').setup({
  ui = {
    icons = {
      package_installed = '',
      package_pending = '',
      package_uninstalled = '',
    },
  },
})

require('mason-lspconfig').setup({
  ui = { check_outdated_servers_on_open = true },
  automatic_installation = true,
  auto_update = true,
  ensure_installed = {
    'tsserver',
    'html',
    'cssls',
    'lua_ls',
    'eslint',
    'jsonls',
    'bashls',
  },
})

require('mason-tool-installer').setup({
  -- automatic_installation = true,
  -- ensure_installed = {
  --   'lua-language-server',
  --   'yaml-language-server',
  --   'prettierd',
  --   'prettier',
  --   'pyright',
  --   'eslint_d',
  --   'isort',
  --   'stylua',
  --   'shellcheck',
  --   'shfmt',
  --   'sql-formatter',
  --   'black',
  --   'shfmt',
  --   'jq',
  --   'eslint',
  --   'bashls',
  --   'shfmt',
  -- },
})

local dap_servers = {
  'js-debug-adapter',
  'node-debug2-adapter',
  'js',
  'node2',
  'chrome',
}

-- require('mason-nvim-dap').setup({
--   ensure_installed = dap_servers,
--   automatic_installation = true,
--   automatic_setup = true,
--   auto_update = true,
-- })
