lua << EOF
local lspconfig = require("lspconfig")
local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

local on_attach = function(client, bufnr)
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
end


local lsp_installer_servers = require'nvim-lsp-installer.servers'
local tsopts = {
    on_attach = function(client, bufnr)
        --nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
	on_attach(client, bufnr)
    end,
}

local server_available, requested_server = lsp_installer_servers.get_server("tsserver")
if server_available then
    requested_server:on_ready(function ()
        local opts = {}
        requested_server:setup(tsopts)
    end)
    if not requested_server:is_installed() then
        -- Queue the server to be installed
        requested_server:install()
    end
end
EOF
