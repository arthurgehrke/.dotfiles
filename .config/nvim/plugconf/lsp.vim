" npm i -g typescript typescript-language-server
" npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d

lua << EOF
local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    --...
    root_dir = function()
        return vim.loop.cwd()
    end

    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
end

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = false,
        -- This sets the spacing and the prefix, obviously.
        virtual_text = false,
        loclist = false
    }
)

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = {
        "javascript",
        "javascriptreact",
        "json",
        "typescript",
        "typescriptreact",
        "css",
        "less",
        "scss",
        "markdown",
        "pandoc"
    },
    init_options = {
        linters = {
            eslint = {
                command = "eslint_d",
                rootPatterns = {".git"},
                debounce = 100,
                args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
                sourceName = "eslint_d",
                parseJson = {
                    errorsRoot = "[0].messages",
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "[eslint] ${message} [${ruleId}]",
                    security = "severity"
                },
                securities = {
                    [2] = "error",
                    [1] = "warning"
                }
            }
        },
        filetypes = {
            javascript = "eslint",
            javascriptreact = "eslint",
            typescript = "eslint",
            typescriptreact = "eslint"
        },
        formatters = {
            eslint_d = {
                command = "eslint_d",
                args = {"--stdin", "--stdin-filename", "%filename", "--fix-to-stdout"},
                rootPatterns = {".git"}
            },
            prettier = {
                command = "prettier",
                args = {"--stdin-filepath", "%filename"}
            }
        },
        formatFiletypes = {
            css = "prettier",
            javascript = "eslint_d",
            javascriptreact = "eslint_d",
            json = "prettier",
            scss = "prettier",
            less = "prettier",
            typescript = "eslint_d",
            typescriptreact = "eslint_d",
            json = "prettier",
            markdown = "prettier"
        }
    }
}

-- TypeScript
nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = {"typescript", "typescriptreact", "typescript.tsx"},
    cmd = {
        "typescript-language-server",
        "--stdio"
    }
}
EOF

let g:completion_enable_auto_popup = 0

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gvd <cmd>:vsplit<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gsd <cmd>:split<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <space>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <space>vrh :lua vim.lsp.buf.signature_help()<CR>
nnoremap go <c-o>
nnoremap <space>= :lua vim.lsp.buf.formatting()<CR>
