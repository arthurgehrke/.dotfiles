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
	"cssls",
	"lua_ls",
	"angularls",
	"bashls",
	"dockerls",
	"jsonls",
	"tsserver",
	'vimls',
	'yamlls',
	'dockerls',
	'csharp_ls',
	'sqlls'
}

local null_ls_servers = {
	"tsserver",
	"html",
	"cssls",
	"lua_ls",
	"angularls",
	"bashls",
	"dockerls",
	"jsonls",
	"tsserver",
	"sumneko_lua",
  'bashls',
  'yamlls',
  'eslint',
  'stylua',
  'prettierd',
	"rustfmt",
	"eslint_d",
	'jsonlint',
	'pg_format',
	'ymlfix',
	'lua_format',
	'fixjson',
	'sql_formatter',
	'sqlls'
}

local custom_servers = {
  'bash-language-server',
  'vim-language-server',
  'shellcheck',
  'luacheck',
  'shellcheck',
  'shfmt',
  'vint',
}

local dap_servers = {
	"js-debug-adapter", 
	"vscode-node-debug2", 
	"node-debug2-adapter", 
	"js", 
	"node2", 
	"chrome",
}

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = lsp_servers,
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
  auto_update = true,
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = null_ls_servers,
  automatic_setup = false,
  automatic_instalation = true,
  auto_update = true,
})

mason_dap.setup({
  ensure_installed = dap_servers,
  automatic_installation = true,
  automatic_setup = true,
  auto_update = true,
})

mason_tool.setup({
  ensure_installed = custom_servers,
	automatic_installation = true,
  auto_update = true,
})
EOF