" npm i -g typescript typescript-language-server
" npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d

lua << EOF
local lspconfig = require('lspconfig')
local protocol = require('vim.lsp.protocol')

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { silent = true, noremap = true }

  -- Mappings.
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gtd', '<cmd>split<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>sld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>od', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', 'sn', ':<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'sp', ':<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>af', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)

  vim.keymap.set('n', '<space>al', function()
    vim.lsp.buf.format { async = true }
  end, opts)

  vim.keymap.set({'n', 'x'}, 'gq', function()
    vim.lsp.buf.format({
    async = false, 
    timeout_ms = 10000
    -- filter = allow_format({'lua_ls', 'rust_analyzer'})
    })
  end)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async=true})' ]])

  if client.name == "tsserver" 
			or client.name == "html"
			or client.name == "cssls"
			or client.name == "jsonls"
	then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
      buf_set_keymap('n', '<space>zal', '<cmd>TypescriptAddMissingImports<CR>', opts)
      buf_set_keymap('n', '<space>lak', '<cmd>TypescriptOrganizeImports<CR>', opts)
      buf_set_keymap('n', '<F2>', '<cmd>TypescriptRenameFile<CR>', opts)
      buf_set_keymap('n', 'gwd', '<cmd>TypescriptGoToSourceDefinition<cr>', { buffer = buffer, desc = 'Go To Source Definition' })
      buf_set_keymap('n', 'gsd', '<cmd>:vsplit<cr><cmd>TypescriptGoToSourceDefinition<cr>', { buffer = buffer, desc = 'Go To Source Definition' })
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
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.completion.vsnip,
    null_ls.builtins.diagnostics.vint,
    require("typescript.extensions.null-ls.code-actions"),
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

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.tsserver.setup({
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
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

require("typescript").setup({
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "non-relative"
    }
  },
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  server = { -- pass options to lspconfig's setup method
      on_attach = on_attach
  },
  vim.keymap.set(
    'n',
    '<space>gD',
    '<cmd>TypescriptGoToSourceDefinition<cr>',
    { buffer = buffer, desc = 'Go To Source Definition' }
  )
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
nnoremap <silent> vd <cmd>vim.diagnostic.open_float()<CR>
" nnoremap go <c-o>

" compe
let g:completion_enable_auto_popup = 0
set completeopt=menu,preview,menuone,noselect
" set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" eslint
" Autofix entire buffer with eslint_d:
nnoremap <space>ef mF:%!eslint_d --stdin --fix-to-stdout<CR>`F
" Autofix visual selection with eslint_d:
vnoremap <space>ef :!eslint_d --stdin --fix-to-stdout<CR>gv
