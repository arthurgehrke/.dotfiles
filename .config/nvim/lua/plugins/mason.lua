local servers = {
  'yamlls',
  'jsonls',
  'sqlls',
}

-- enable mason
require("mason").setup()

require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "lua_ls",
    -- "pyright",
  }
})

require('mason-tool-installer').setup({
  ensure_installed = {
    'lua-language-server',
    'yaml-language-server',
    'stylua',
    'shellcheck',
    'sql-formatter',
    'jq',
    'fixjson',
    -- 'prettier',
    'eslint',
    'bashls',
  }
})

local dap_servers = {
  "js-debug-adapter",
  "node-debug2-adapter",
  "js",
  "node2",
  "chrome",
}

require("mason-nvim-dap").setup({
  ensure_installed = dap_servers,
  automatic_installation = true,
  automatic_setup = true,
  auto_update = true,
})
