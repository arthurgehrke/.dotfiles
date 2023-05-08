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

local lsp_servers = {
	"tsserver",
	"html",
	"cssls",
	"lua_ls",
	"angularls",
	"bashls",
	"cssmodules_ls",
	"dockerls",
	"jsonls",
	"tsserver",
	'vimls',
	'marksman',
	'csharp_ls'
}

local null_ls_servers = {
	"tsserver",
	'vint',
	"html",
	"cssls",
	"lua_ls",
	"angularls",
	"bashls",
	"cssmodules_ls",
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
	'sqlfluff',
	'pg_format',
	'ymlfix',
	'lua_format',
	'fixjson',
	'sql_formatter'
}

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = lsp_servers,
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = null_ls_servers,
  automatic_setup = false,
  automatic_instalation = true
})
EOF
