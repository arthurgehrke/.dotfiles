" npm i -g typescript typescript-language-server
" npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d

lua << EOF
local lspconfig = require('lspconfig')
local protocol = require('vim.lsp.protocol')

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer

local keymap = vim.keymap -- for conciseness

local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { silent = true, noremap = true }

  -- Mappings.
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua require(\'fzf-lua\').lsp_definitions({jump_to_single_result = true })<CR>', opts)
  buf_set_keymap('n', 'gtd', '<cmd>split<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>sld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<space>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  vim.keymap.set('n', '<space>ac', vim.lsp.buf.code_action, opts)
  vim.keymap.set('x', '<space>ac', function() return vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, opts)
  vim.keymap.set('v', '<space>lf', function() return vim.lsp.buf.format() end, opts)

  vim.api.nvim_set_keymap('n', '<space>c', ':lua vim.lsp.buf.format({async = true})<CR>', { noremap = true, silent = true })


  buf_set_keymap('n', '<space>od', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>lc', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>af', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
  keymap.set('n', '<space>za', function() vim.lsp.buf.format { async = true } end, bufopts)

  vim.keymap.set('n', '<space>al', function()
    vim.lsp.buf.format { async = true }
  end, opts)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async=true})' ]])

 if client.name == "tsserver" then
   client.server_capabilities.documentFormattingProvider = false
   client.server_capabilities.documentRangeFormattingProvider = false
   keymap.set("n", "<space>re", ":TypescriptRenameFile<CR>") -- rename file and update imports
   keymap.set("n", "<space>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
   keymap.set("n", "<space>ra", ":TypescriptAddMissingImports<CR>") -- remove unused variables (not in youtube nvim video)
   end

end

-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
  debug = true,
  auto_restart = true,
  autostart = true,
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	end,
  sources = { 
    null_ls.builtins.formatting.prettier.with {
      only_local = "node_modules/.bin",
    },
    null_ls.builtins.formatting.prettierd.with {
        filetypes = { "json" },
    },
		null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.vsnip,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "postgres" }, -- change to your dialect
    }),
    require('typescript.extensions.null-ls.code-actions'),
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.cspell.with({
      diagnostic_config = {
        underline = true,
        virtual_text = false,
        signs = false,
        update_in_insert = false,
        severity_sort = true,
      },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.INFO
      end,
      filetypes = { 'markdown', 'latex', 'text' },
    }),
		null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace.with({
			-- I don't want this for all filetypes since it
			-- also removes whitespace inside string literals.
			filetypes = { "markdown", "yaml", "gitcommit" },
		}),
		null_ls.builtins.formatting.xmllint,
 }
})

-- capabilities
local cmp = require'cmp'
cmp.setup({
    preselect = cmp.PreselectMode.None,
    window = {
      completion = cmp.config.window.bordered({ winhighlight = 'Normal:Normal,FloatBorder:Comment,CursorLine:Visual,Search:None' }),
      documentation = cmp.config.window.bordered({ winhighlight = 'Normal:Normal,FloatBorder:Comment,CursorLine:Visual,Search:None' }),
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-a>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "buffer-lines" },
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'path' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    }),
  })

function setAutoCmp(mode)
  if mode then
    cmp.setup({
      completion = {
        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
      }
    })
  else
    cmp.setup({
      completion = {
        autocomplete = false
      }
    })
  end
end
setAutoCmp(false)

-- enable automatic completion popup on typing
vim.cmd('command! AutoCmpOn lua setAutoCmp(true)')
-- disable automatic competion popup on typing
vim.cmd('command! AutoCmpOff lua setAutoCmp(false)')

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
      codeActionLiteralSupport = {
          codeActionKind = {
              valueSet = {
                 "",
                 "quickfix",
                 "refactor",
                 "refactor.extract",
                 "refactor.inline",
                 "refactor.rewrite",
                 "source",
                 "source.organizeImports",
              };
          };
      };
}

lspconfig.tsserver.setup({
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities
})

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.jsonls.setup{
  on_attach = on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.document_formatting = true
  end,
  settings = {
    format = { enable = true },
  },
})

lspconfig.bashls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.document_formatting = true
  end,
	capabilities = capabilities,
  filetypes = { "sql"},
})

lspconfig.vimls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.document_formatting = true
  end,
	capabilities = capabilities,
  filetypes = { "vim"},
})

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["https://bitbucket.org/atlassianlabs/atlascode/raw/main/resources/schemas/pipelines-schema.json"] = "./bitbucket-pipelines.yml",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "./schema.yml"
      }
    }
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

require("typescript").setup({
  capabilities = capabilities,
  server = {
    on_attach = on_attach,
  },
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "non-relative"
    }
  },
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  server = { -- pass options to lspconfig's setup method
      on_attach = on_attach
  }
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      update_in_insert = true,
      virtual_text = false,
      loclist = false,
      signs = false,
      -- virtual_text = { spacing = 4, prefix = "●" },
      severity_sort = true,
    }
)

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
EOF
nnoremap <silent> gvd <cmd>:vsplit<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gsd <cmd>:split<cr><cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap go <c-o>

" compe
let g:completion_enable_auto_popup = 0
set completeopt=menu,preview,menuone,noselect
" set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap <space>ew :e <C-R>=expand("%:.:h") . "/"<CR>
nnoremap <space>lcd :lcd %:h<CR>
nnoremap <space>tcd :tcd %:h<CR>
