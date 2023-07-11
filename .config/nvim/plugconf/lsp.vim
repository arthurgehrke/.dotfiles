" npm i -g typescript typescript-language-server
" npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d

lua << EOF
local status, saga = pcall(require, "lspsaga")
if (not status) then return end

local keymap = vim.keymap
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

local lspconfig = require('lspconfig')
local protocol = require('vim.lsp.protocol')
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  local opts = {buffer = bufnr}

  vim.keymap.set({'n', 'x'}, 'gq', function()
    vim.lsp.buf.format({async = false, timeout_ms = 10000})
  end, opts)
end)

lsp.configure('lua_ls', {
 settings = {
     Lua = {
         diagnostics = {
              globals = { 'vim' }
         }
     }
 }
})

-- Code actions

saga.init_lsp_saga {
  use_saga_diagnostic_sign = false,
  code_action_prompt = {
    enable = false,
    sign = false,
    virtual_text = true,
  },
  server_filetype_map = {
    typescript = 'typescript'
  }
}

lsp.setup()

local keymap = vim.keymap -- for conciseness

local on_attach = function(client, bufnr)

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      local opts = { silent = true, noremap = true }

      -- Mappings.
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      buf_set_keymap('n', 'gtd', '<cmd>split<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>sld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      -- buf_set_keymap('n', '<space>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

      
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<space>ad', vim.lsp.buf.code_action, opts)

      vim.keymap.set('n', '<space>ac', vim.lsp.buf.code_action, opts)
      -- vim.keymap.set('x', '<space>ac', function() return vim.lsp.buf.code_action() end, opts)
      vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)

      buf_set_keymap('n', '<space>od', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>lc', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
      buf_set_keymap('n', '<space>af', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)

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
      auto_restart = true,
      run_on_start = true,
      autostart = true,
      debug = false,
      on_attach = function(client, bufnr)
         client.server_capabilities.documentFormattingProvider = true
         client.server_capabilities.documentRangeFormattingProvider = true
      end,
      sources = {
         null_ls.builtins.formatting.prettier.with {
            only_local = "node_modules/.bin",
         },
         null_ls.builtins.formatting.prettierd,
         null_ls.builtins.diagnostics.eslint_d,
         null_ls.builtins.diagnostics.jsonlint,
         null_ls.builtins.formatting.fixjson,
         null_ls.builtins.formatting.pg_format.with {
            filetypes = { "sql", "pgsql" },
         },
         null_ls.builtins.formatting.stylua,
         null_ls.builtins.code_actions.eslint_d,
         -- null_ls.builtins.code_actions.ts_node_action,
         null_ls.builtins.diagnostics.eslint_d,
         null_ls.builtins.formatting.lua_format,
         -- require('typescript.extensions.null-ls.code-actions'),
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
         { name = 'nvim_lsp' },
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
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}

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

local lsp_flags = {
  debounce_text_changes = 150,
}

lspconfig.tsserver.setup({
   on_attach = on_attach,
   auto_restart = true,
   run_on_start = true,
   autostart = true,
   cmd = { "typescript-language-server", "--stdio" },
   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
   capabilities = capabilities
})

lspconfig.lua_ls.setup {
   on_attach = on_attach,
   capabilities = capabilities,
   filetypes = { "lua" },
}

lspconfig.jsonls.setup {
   settings = {
      format = { enable = true },
      json = {
         validate = { enable = true },
      },
   },
   filetypes = { "json" },
   on_attach = on_attach
}

lspconfig.eslint.setup({
  filestypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
  settings = {
    workingDirectory = { mode = 'auto' },
    lint = { enable = true },
  },
})

lspconfig.bashls.setup({})

lspconfig.vimls.setup({})

lspconfig.yamlls.setup({
   capabilities = capabilities,
   on_attach = on_attach,
   filetypes = { "yaml" },
})

-- require("typescript").setup({
--    capabilities = capabilities,
--    server = {
--       on_attach = on_attach,
--    },
--    init_options = {
--       preferences = {
--          importModuleSpecifierPreference = "non-relative"
--       }
--    },
--    disable_commands = false, -- prevent the plugin from creating Vim commands
--    debug = false, -- enable debug logging for commands
--    server = { -- pass options to lspconfig's setup method
--       on_attach = on_attach
--    }
-- })

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

vim.o.updatetime = 250
EOF

nnoremap <silent> gvd <cmd>:vsplit<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gsd <cmd>:split<cr><cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap go <c-o>

" compe
let g:completion_enable_auto_popup = 0
set completeopt=menu,preview,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap <space>ew :e <C-R>=expand("%:.:h") . "/"<CR>
nnoremap <space>lcd :lcd %:h<CR>
nnoremap <space>tcd :tcd %:h<CR>
