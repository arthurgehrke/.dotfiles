lua << EOF
local schemas = require("schemastore")
local util = require("lspconfig.util")
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
local rawCapabilitiesWithoutFormatting = vim.lsp.protocol.make_client_capabilities()
rawCapabilitiesWithoutFormatting.textDocument.formatting = false
rawCapabilitiesWithoutFormatting.textDocument.rangeFormatting = false
local capabilitiesWithoutFormatting = require("cmp_nvim_lsp").default_capabilities(rawCapabilitiesWithoutFormatting)

local border = {
  { '╭', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╮', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '╯', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╰', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}
-- Lsp Hover & SignatureHelp {{{

-- Single border for hover floating window.
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

-- Single border for signature help window.
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
})

-- Single border for :LspInfo window.
require('lspconfig.ui.windows').default_options = {
  border = 'single',
}

local servers = {
    "bashls",
    "yamlls",
    "cssls",
    "eslint",
    "jsonls",
    "html",
    "jsonls",
    "cssls",
    "sqlls",
    -- "lua_ls",
    "tsserver",
    -- "pyright",
    "vimls",
    "marksman",
}

-- Mappings.
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>od", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
    vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", function()
        vim.lsp.buf.code_action({
          --- Filter unwanted code actions
          filter = function(action)
            return action.title ~= "Move to a new file"
              and action.title ~= "Generate 'get' and 'set' accessors"
          end,
    })
		end, opts)
    vim.keymap.set("n", "ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>as', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set('n', '<space>gq', '<cmd>lua vim.lsp.buf.format({ async = false })<CR>', bufopts)
    -- vim.keymap.set('n', 'gq', '<cmd>lua vim.lsp.buf.format({ async = false })<CR>', bufopts)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    if client.name == "tsserver" then
			vim.keymap.set("n", "<space>i", "<cmd>TypescriptAddMissingImports<cr>", bufopts)
			vim.keymap.set("n", "<space>0", "<cmd>TypescriptRemoveUnused<cr>", bufopts)
			vim.keymap.set("n", "<space>rf", "<cmd>TypescriptRenameFile<cr>", bufopts)
		end

    if client.name == 'typescript-tools' or client.name == 'tsserver' then
			--- Organize imports for TypeScript files. Unfortunate to have to do two
			--- separate actions, but unfortunately it's the way the language server is
			--- setup.
			vim.keymap.set("n", "<space>ai", "<cmd>TSToolsAddMissingImports<cr>", bufopts)
			vim.keymap.set("n", "<space>ao", "<cmd>TSToolsRemoveUnusedImports<cr>", bufopts)
			--- Rename file keymap similar to rename variable
			vim.keymap.set("n", "<space>rf", "<cmd>TSToolsRenameFile<cr>", bufopts)
		end
end

for _, lsp in pairs(servers) do
  require("lspconfig")[lsp].setup({
      on_attach = on_attach,
      flags = {
          debounce_text_changes = 300,
      },
      capabilities = lsp_capabilities,
  })
end

require("lspconfig").cssls.setup({
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
    single_file_support = true,
    on_attach = on_attach,
})

require('lspconfig').eslint.setup{
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
}

require('lspconfig').sqlls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

require('lspconfig').vimls.setup({
    on_attach = on_attach,
    handlers = handlers,
    init_options = {
        diagnostics = {
            enable = true,
        },
    },
})

require("lspconfig").marksman.setup({
  cmd = { "marksman", "server" },
  filetypes = {
    "markdown",
    "md",
    "latex",
    "tex",
    "org",
    "plaintext",
    "txt"
  },
  single_file_support = true,
  on_attach = on_attach,
})

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "it", "describe", "before_each", "use" },
      },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
          -- vim.fn.expand("~/.luarocks"),
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      completion = {
        enable = true,
        showParams = true,
      },
    },
  },
  on_attach = on_attach,
  capabilities = lsp_capabilities,
})

require("lspconfig").bashls.setup({
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "zsh" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },
  single_file_support = true,
  on_attach = on_attach,
})

-- require("lspconfig").pyright.setup({
--         on_attach = on_attach,
--         capabilities = lsp_capabilities,
--         settings = {
--             python = {
--                 analysis = {
--                     autoImportCompletions = false,
--                     useLibraryCodeForTypes = false
--                 }
--             }
--         },
--         before_init = function(_, config)
--             config.settings.python.pythonPath =
--                 require("lspconfig").util.path.join(vim.env.VIRTUAL_ENV, "bin", "python")
--         end
-- })

require("lspconfig").pylsp.setup({
  filetypes = { "python" },
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
})

require("lspconfig").html.setup({
  settings = {
      format = {enable = true},
      json = {
          schemas = schemas.json.schemas().html
      }
  },
  filetypes = {"html"},
  on_attach = on_attach,
})

require("lspconfig").jsonls.setup({
  settings = {
      format = {enable = true},
      json = {
          schemas = schemas.json.schemas().jsonls
      }
  },
  filetypes = {"json"},
  on_attach = on_attach,
})

-- require('lspconfig').tsserver.setup({
--    -- on_init = function(client)
--    --   client.server_capabilities.documentFormattingProvider = false
--    --   client.server_capabilities.documentFormattingRangeProvider = false
--    -- end,
--    capabilities = lsp_capabilities,
--    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
--    handlers = handlers,
--    root_dir = util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git'),
--    single_file_support = true,
--    on_attach = on_attach,
--    name = 'tsserver',
--    cmd = {'typescript-language-server', '--stdio'},
--    -- on_attach = function(client)
--    --   client.server_capabilities.document_formatting = false
--    -- end,
-- })

-- require("lspconfig").tsserver.setup({
--   cmd = { "typescript-language-server", "--stdio" },
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--   init_options = {
--     hostInfo = "neovim",
--   },
--   root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
--   capabilities = lsp_capabilities,
--   on_attach = on_attach,
-- })

require("lspconfig").tsserver.setup({
  on_attach = on_attach,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
      },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  },
  flags = {
      debounce_text_changes = 300,
  },
  capabilities = capabilitiesWithoutFormatting,
  settings = {
      documentFormatting = false,
  },
  root_dir = require("lspconfig.util").find_git_ancestor,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
  cmd = { "typescript-language-server", "--stdio" }
})

require("lspconfig").yamlls.setup({
  settings = {
      format = {enable = true},
      json = {
          schemas = schemas.json.schemas().yamlls
      }
  },
  filetypes = {"yaml"},
  on_attach = on_attach,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  underline = true,
  signs = {severity_limit = vim.diagnostic.severity.INFO},
  update_in_insert = false,
})
EOF
