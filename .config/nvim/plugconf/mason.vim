lua << EOF
-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- import mason-nvim-dap plugin safely
local mason_dap_status, mason_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_status then
	return
end

local ok, mason_tool = pcall(require, "mason-tool-installer")
if not ok then return end

local lsp_servers = {
	"tsserver",
	"html",
	"vimls",
	"bashls",
	"dockerls",
	"jsonls",
	"yamlls",
	"dockerls",
  "pyright",
  "lua_ls",
  "marksman"
}

local dap_servers = {
	"js-debug-adapter", 
	"node-debug2-adapter", 
	"js", 
	"node2", 
	"chrome",
}

-- enable mason
require("mason").setup()
require("mason-lspconfig").setup({
  -- automatically install language servers setup below for lspconfig
  automatic_installation = true
})

require('mason-tool-installer').setup({
ensure_installed = {
  'bash-language-server',
  'lua-language-server',
  'vim-language-server',
  'stylua',
  'shellcheck',
  'sqlfmt',
  'json-to-struct',
  'jq',
  'vint',
  'yamllint',
  'yamlfmt',
  'yamlls',
  'dockerls',
  'sqlls',
  }
})

mason_null_ls.setup({
	ensure_installed = {'eslint_d', 'jsonlint', 'bashls', 'cssls', 'html', 'jsonls', 'lua_ls'},
	automatic_installation = true,
	handlers = {},
})

mason_dap.setup({
  ensure_installed = dap_servers,
  automatic_installation = true,
  automatic_setup = true,
  auto_update = true,
})
EOF
