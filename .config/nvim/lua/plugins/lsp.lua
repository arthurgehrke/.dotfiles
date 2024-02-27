local schemas = require("schemastore")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});

local border                                        = {
  { '╭', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╮', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '╯', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╰', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

local handlers                                      = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}
-- Lsp Hover & SignatureHelp {{{

-- Single border for hover floating window.
vim.lsp.handlers['textDocument/hover']              = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

vim.lsp.handlers['textDocument/signatureHelp']      = vim.lsp.with(vim.lsp.handlers['signature_help'], {
  border = 'single',
  close_events = { 'CursorMoved', 'BufHidden' },
})

-- Single border for signature help window.
vim.lsp.handlers['textDocument/signatureHelp']      = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = false })


local servers = {
  "tsserver",
  "cssls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  -- "r_language_server"
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    virtual_text = false,
    underline = true,
    signs = false,
    severity_sort = false,
    update_in_insert = false,
  }
)

vim.diagnostic.config({
  update_in_insert = false,
  underline = true,
  signs = false,
  severity_sort = false,
  virtual_text = false,
})

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.opt.isfname:append("@-@")

  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  --   virtual_text = false,
  --   underline = true,
  --   signs = true,
  --   severity_sort = false,
  --   update_in_insert = false,
  -- })


  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Mappings.
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<S-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, bufopts)
  vim.keymap.set("n", "ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gq', function()
    vim.lsp.buf.format { async = true }
  end, opts)
  vim.keymap.set('n', '<space>lf', function()
    vim.lsp.buf.format { async = false }
  end, opts)

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

  -- local signs = {
  --    { name = "DiagnosticSignError", text = "" },
  --    { name = "DiagnosticSignWarn", text = "" },
  --    { name = "DiagnosticSignHint", text = "" },
  --    { name = "DiagnosticSignInfo", text = "" },
  --  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

require("lspconfig").cssls.setup({})

require("lspconfig").eslint.setup({
  -- root_dir = root_pattern(
  --  "package.json",
  --  ".eslintrc",
  -- ".eslintrc.json",
  --  ".eslintrc.yaml",
  --  ".eslintrc.yml",
  --  ".eslintrc.js",
  --  ".eslintrc.cjs"
  --),
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "save", -- or `save`
  },
  settings = { documentFormatting = false },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end
})

require('lspconfig').sqlls.setup({})

require('lspconfig').vimls.setup({
  on_attach = on_attach,
  init_options = {
    diagnostics = {
      enable = true,
    },
  },
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
        globals = { 'vim' }
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
  on_attach = on_attach
})

require("lspconfig").bashls.setup({})

-- require("lspconfig").pyright.setup({
--         on_attach = on_attach,
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

require("lspconfig").pyright.setup({})

require("lspconfig").html.setup({
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "php" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
  },
})

require("lspconfig").jsonls.setup({
  settings = {
    format = { enable = true },
    json = {
      schemas = schemas.json.schemas().jsonls
    }
  },
  filetypes = { "json" }
})

require("lspconfig").tsserver.setup({
  on_attach = on_attach,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  cmd = { "typescript-language-server", "--stdio" },
  single_file_support = false,
  -- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", "index.js", "app.js"),
  root_dir = function() return vim.loop.cwd() end
})

-- require("lspconfig").yamlls.setup({
--   settings = {
--       format = {enable = true},
--       json = {
--           schemas = schemas.json.schemas().yamlls
--       }
--   },
--   filetypes = {"yaml"},
--   on_attach = on_attach,
-- })

require("lspconfig").yamlls.setup({
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
})

for _, lsp in pairs(servers) do
  require("lspconfig")[lsp].setup({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,     -- 300
    },
    root_dir = function() return vim.loop.cwd() end
  })
end
