lua << EOF
-- enable mason
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "tsserver",
  },
  automatic_installation = true
})

require('mason-tool-installer').setup({
  ensure_installed = {
    'bash-language-server',
    'lua-language-server',
    'yaml-language-server',
    'vim-language-server',
    'stylua',
    'shellcheck',
    'jq',
    'prettier',
    'prettierd',
    'eslint_d',
    'eslint',
    'fixjson', 
    'jsonls',
    'yamlfix',
    'shellcheck',
    'black',
    'isort',
    'sql-formatter',
    'pylsp',
    'vimls',
    'yamllint',
    'yamlls',
    'dockerls',
    'sqlls',
  },
  auto_update = true,
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
EOF
