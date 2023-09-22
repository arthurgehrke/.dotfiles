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
	-- "lua_ls",
	"vimls",
	"bashls",
	"vtsls",
	"dockerls",
	"jsonls",
	"yamlls",
	"angularls",
	"dockerls",
}

local dap_servers = {
	"js-debug-adapter", 
	"node-debug2-adapter", 
	"js", 
	"node2", 
	"chrome",
}

-- enable mason
mason.setup({
 pip = {
    upgrade_pip = true,
  }
})

mason_null_ls.setup({
	ensure_installed = {'eslint_d', 'jsonlint', 'vtls', 'text-lint'},
	automatic_installation = true,
	handlers = {},
})

mason_lspconfig.setup({
	ensure_installed = lsp_servers,
	automatic_installation = true, -- not the same as ensure_installed
  auto_update = true,
})


mason_dap.setup({
  ensure_installed = dap_servers,
  automatic_installation = true,
  automatic_setup = true,
  auto_update = true,
})

local lspconfig = require('lspconfig')
local get_servers = require('mason-lspconfig').get_installed_servers

for _, server_name in ipairs(get_servers()) do
  lspconfig[server_name].setup({
    capabilities = lsp_capabilities,
  })
end
EOF
