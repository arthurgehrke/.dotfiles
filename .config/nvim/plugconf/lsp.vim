lua << EOF
local ok, lsp = pcall(require, "lsp-zero")
if not ok then
    return
end

local opt = vim.opt
local keymap = vim.keymap
local lspconfig = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local schemas = require("schemastore")
local cmp = require "cmp"
local util = require("lspconfig.util")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

lsp.format_mapping(
    "gq",
    {
        format_opts = {
            async = false,
            timeout_ms = 10000
        },
        servers = {
            ["lua_ls"] = {"lua"},
            ["rust_analyzer"] = {"rust"},
            ["null-ls"] = {"typescript", "typescriptreact", "json", "javascript"}
        }
    }
)

lsp.set_sign_icons(
    {
        error = "",
        warn = "",
        hint = "",
        info = ""
    }
)


lsp.on_attach(
    function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        vim.keymap.set(
            "n",
            "gd",
            function()
                vim.lsp.buf.definition()
            end,
            opts
        )
        vim.keymap.set(
            "n",
            "K",
            function()
                vim.lsp.buf.hover()
            end,
            opts
        )
        vim.keymap.set("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        vim.keymap.set(
            "n",
            "<space>vrr",
            function()
                vim.lsp.buf.references()
            end,
            opts
        )
        vim.keymap.set(
            "n",
            "<space>vrn",
            function()
                vim.lsp.buf.rename()
            end,
            opts
        )
        vim.keymap.set( "i",
            "<C-h>",
            function()
                vim.lsp.buf.signature_help()
            end,
            opts
        )
        vim.keymap.set(
            {"n", "v"},
            "<space>af",
            function()
                vim.lsp.buf.format({async = true})
            end,
            {silent = true, desc = "format"}
        )

        vim.keymap.set(
            {"n", "x"},
            "gq",
            function()
                vim.lsp.buf.format({async = false, timeout_ms = 10000})
            end,
            opts
        )

        vim.keymap.set({"n", "x"}, "<space>al", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        vim.keymap.set({"n", "x"}, "<space>ra", ":TypescriptAddMissingImports<CR>")

        vim.keymap.set(
            {"n"},
            "<space>k",
            function()
                vim.lsp.buf.signature_help()
            end,
            {silent = true, desc = "toggle signature"}
        )

        vim.keymap.set(
            {"n"},
            "<space>od",
            function()
                vim.diagnostic.open_float()
            end,
            {silent = true, desc = "open diags"}
        )

        vim.keymap.set(
            {"n"},
            "<space>oc",
            function()
                vim.diagnostic.show_line_diagnostics()
            end,
            {silent = true, desc = "open diags"}
        )

        vim.keymap.set(
            {"n", "v"},
            "<space>ca",
            function()
                vim.lsp.buf.code_action()
            end,
            {silent = true, desc = "toggle signature"}
        )
    end
)

require("lspconfig").lua_ls.setup(
    {
        on_attach = function(client, bufnr)
            local opts = {noremap = true, silent = true}
            local keymap = vim.api.nvim_buf_set_keymap
            keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        end
    }
)

lsp.setup()

local opts = {noremap = true, silent = true}
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    client.server_capabilities.document_formatting = false
    vim.keymap.set("n", "<space>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set(
        "n",
        "<space>wl",
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        bufopts
    )
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set(
        "n",
        "<space>af",
        function()
            vim.lsp.buf.format {async = true}
        end,
        bufopts
    )
end

local lsp_flags = {
    debounce_text_changes = 150
}

local nvim_lsp = require "lspconfig"
local servers = {"tsserver", "pyright"}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities
    }
end

-- prettier
local prettier = require("prettier")
local null_ls = require("null-ls")

null_ls.setup(
    {
        debug = false,
        sources = {
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.latexindent
        },
        on_attach = function(client, bufnr)
            if client.server_capabilities.documentFormattingProvider then
                vim.cmd("nnoremap <silent><buffer> <Leader>[ :lua vim.lsp.buf.formatting()<CR>")
            -- format on save
            --vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true})")
            end

            if client.server_capabilities.documentRangeFormattingProvider then
                vim.cmd("xnoremap <silent><buffer> <Leader>[ :lua vim.lsp.buf.range_formatting({})<CR>")
            end
        end
    }
)

prettier.setup(
    {
        bin = "prettier", -- or `'prettierd'` (v0.22+)
        filetypes = {
            "css",
            "graphql",
            "html",
            "javascript",
            "javascriptreact",
            "json",
            "less",
            "markdown",
            "scss",
            "typescript",
            "typescriptreact",
            "yaml"
        },
        cli_options = {
            -- https://prettier.io/docs/en/cli.html#--config-precedence
            config_precedence = "prefer-file" -- or "cli-override" or "file-override"
        }
    }
)

cmp.setup(
    {
        preselect = cmp.PreselectMode.None,
        window = {
            documentation = {
                border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
            }
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        },
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                vim_item.menu =
                    ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]"
                })[entry.source.name]
                return vim_item
            end
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
                ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
                ["<CR>"] = cmp.mapping.confirm({select = true}),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["q"] = cmp.mapping.abort()
            }
        ),
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "luasnip"},
                {name = "buffer"},
                {name = "path"}
            }
        )
    }
)

function setAutoCmp(mode)
    if mode then
        cmp.setup(
            {
                completion = {
                    autocomplete = {require("cmp.types").cmp.TriggerEvent.TextChanged}
                }
            }
        )
    else
        cmp.setup(
            {
                completion = {
                    autocomplete = false
                }
            }
        )
    end
end
setAutoCmp(false)

-- enable automatic completion popup on typing
vim.cmd("command! AutoCmpOn lua setAutoCmp(true)")
-- disable automatic competion popup on typing
vim.cmd("command! AutoCmpOff lua setAutoCmp(false)")

require('lspconfig').tsserver.setup({
   -- on_init = function(client)
   --   client.server_capabilities.documentFormattingProvider = false
   --   client.server_capabilities.documentFormattingRangeProvider = false
   -- end,
   capabilities = capabilities,
   filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
   -- cmd = { "typescript-language-server", "--stdio" },
   on_attach = function(client)
     client.server_capabilities.document_formatting = false
   end,
})

require("lspconfig").yamlls.setup(
    {
        settings = {
            format = {enable = true},
            json = {
                schemas = schemas.json.schemas().yamlls
            }
        },
        filetypes = {"yaml"}
    }
)

require("lspconfig").jsonls.setup(
    {
        settings = {
            format = {enable = true},
            json = {
                schemas = schemas.json.schemas().jsonls
            }
        },
        filetypes = {"json"}
    }
)

require("lspconfig").html.setup(
    {
        settings = {
            format = {enable = true},
            json = {
                schemas = schemas.json.schemas().html
            }
        },
        filetypes = {"html"}
    }
)

require("lspconfig").yamlls.setup(
    {
        settins = {
            yamlls = {
                format = {enable = true, singleQuote = true},
                validate = true,
                hover = true,
                completion = true,
                schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json"
                },
                schemas = schemas.json.schemas().yamls
            }
        },
        filetypes = {"yaml"}
    }
)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

require("lspconfig").bashls.setup(
    {
        cmd = {
            "bash-language-server",
            "start"
        },
        filetypes = {"zsh"}
    }
)

require("lspconfig").pyright.setup(
    {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            python = {
                analysis = {
                    autoImportCompletions = false,
                    useLibraryCodeForTypes = false
                }
            }
        },
        before_init = function(_, config)
            config.settings.python.pythonPath =
                require("lspconfig").util.path.join(vim.env.VIRTUAL_ENV, "bin", "python")
        end
    }
)

require("lspconfig").marksman.setup(
    {
        capabilities = capabilities,
        filetypes = {
            "markdown",
            "md",
            "latex",
            "tex",
            "org",
            "plaintext",
            "txt"
        },
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.completionProvider = false
        end
    }
)

require("lspconfig").cssls.setup(
    {
        cmd = {"css-languageserver", "--stdio"},
        filetypes = {"css", "scss", "less"},
        settings = {
            css = {
                validate = true
            },
            less = {
                validate = true
            },
            scss = {
                validate = true
            }
        },
        single_file_support = true
    }
)

vim.diagnostic.config(
    {
        virtual_text = false,
        signs = false,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = true
    }
)

vim.opt.updatetime = 100
vim.env.NEOVIM_NODE_VERSION = "v18.12.1"

if vim.fn.has("unix") and vim.env.NEOVIM_NODE_VERSION then
    local node_dir = vim.env.HOME .. "/.nvm/versions/node/" .. vim.env.NEOVIM_NODE_VERSION .. "/bin/"
    if (vim.fn.isdirectory(node_dir)) then
        vim.env.PATH = node_dir .. ":" .. vim.env.PATH
    end
end
EOF

nnoremap <silent> gvd <cmd>:vsplit<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gsd <cmd>:split<cr><cmd>lua vim.lsp.buf.definition()<CR>
