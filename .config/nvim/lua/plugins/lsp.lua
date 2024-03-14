local border = {

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  }),
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

vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = false })

local servers = {
  'tsserver',
  'cssls',
  'html',
  'jsonls',
  'lua_ls',
  -- "r_language_server"
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- delay update diagnostics
  virtual_text = false,
  underline = true,
  signs = true,
  severity_sort = false,
  update_in_insert = false,
})

vim.diagnostic.config({
  update_in_insert = false,
  underline = true,
  signs = false,
  severity_sort = false,
  virtual_text = false,
})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- vim.api.nvim_create_autocmd('CursorHold', {
  --   buffer = bufnr,
  --   callback = function()
  --     local opts = {
  --       focusable = false,
  --       close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
  --       border = 'rounded',
  --       source = 'always',
  --       prefix = ' ',
  --       scope = 'cursor',
  --     }
  --     vim.diagnostic.open_float(nil, opts)
  --   end,
  -- })

  -- Mappings.
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', bufopts)
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', bufopts)
  vim.keymap.set('n', 'gvd', ':vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
  vim.keymap.set('n', 'gsd', ':sp<CR><cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
  vim.keymap.set('n', '<leader>od', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<S-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<C-h>', function()
    vim.lsp.buf.signature_help()
  end, bufopts)
  -- vim.keymap.set("n", "ca", vim.lsp.buf.code_action, bufopts)

  vim.keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action({
      --- Filter unwanted code actions
      filter = function(action)
        return action.title ~= 'Move to a new file' and action.title ~= "Generate 'get' and 'set' accessors"
      end,
    })
  end, bufopts)

  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gq', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
  -- vim.keymap.set("v", "<leader>gq", vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', '<space>gq', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
  vim.keymap.set('n', '<space>lf', function()
    vim.lsp.buf.format({ async = false })
  end, bufopts)

  local signs = { Error = '󰅚 ', Warn = '󰀪 ', Hint = '󰌶 ', Info = '󰋽 ' }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  for _, diag in ipairs({ 'Error', 'Warn', 'Info', 'Hint' }) do
    vim.fn.sign_define('DiagnosticSign' .. diag, {
      text = '',
      texthl = 'DiagnosticSign' .. diag,
      linehl = '',
      numhl = 'DiagnosticSign' .. diag,
    })
  end

  -- for _, sign in ipairs(signs) do
  --   vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  -- end

  if client.name == 'tsserver' then
    vim.keymap.set('n', 'go', '<cmd>TypescriptAddMissingImports<cr>', bufopts)
    vim.keymap.set('n', 'gO', '<cmd>TypescriptRemoveUnused<cr>', bufopts)
    vim.keymap.set('n', '<leader>rf', '<cmd>TypescriptRenameFile<cr>', bufopts)
  end
end

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup({
    root_dir = function()
      return vim.loop.cwd()
    end,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })
end

require('lspconfig').cssls.setup({
  settings = {
    css = { validate = false },
  },
})

require('lspconfig').eslint.setup({
  root_dir = require('lspconfig').util.root_pattern('eslint.config.js', '.eslintrc.js', '.eslintrc.json', '.eslintrc'),
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
  },
  settings = { documentFormatting = false },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
})

require('lspconfig').lua_ls.setup({
  on_attach = on_attach,
  -- on_attach = function(client, bufnr)
  --   client.server_capabilities.documentFormattingProvider = false
  --   on_attach(client, bufnr)
  -- end,
  filetype = { 'lua' },
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
          align_continuous_assign_statement = false,
          align_continuous_rect_table_field = false,
          align_array_table = false,
        },
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

require('lspconfig').bashls.setup({
  on_attach = on_attach,
  filetypes = { 'bash', 'zsh' },
})

require('lspconfig').pylsp.setup({
  on_attach = on_attach,
})

require('lspconfig').html.setup({
  on_attach = on_attach,
  filetypes = { 'html', 'css' },
  init_options = {
    configurationSection = { 'html', 'css' },
    embeddedLanguages = {
      css = true,
    },
  },
})

require('lspconfig').jsonls.setup({
  on_attach = on_attach,
  filetypes = { 'json' },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

require('lspconfig').tsserver.setup({
  on_attach = on_attach,
  handlers = {
    ['textDocument/publishDiagnostics'] = function() end,
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  cmd = { 'typescript-language-server', '--stdio' },
  single_file_support = false,
  root_dir = require('lspconfig').util.root_pattern('tsconfig.json', 'package.json', '.git'),
})

require('lspconfig').yamlls.setup({
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})

require('lspconfig').sqlls.setup({
  on_attach = on_attach,
})

require('typescript-tools').setup({
  on_attach = on_attach,
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
})
