-- npm i -g typescript typescript-language-server
-- npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d

local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local protocol = require("vim.lsp.protocol")

-- local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
-- local enable_format_on_save = function(_, bufnr)
--   vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
--   vim.api.nvim_create_autocmd("BufWritePre", {
--     group = augroup_format,
--     buffer = bufnr,
--     callback = function()
--       vim.lsp.buf.format({ bufnr = bufnr })
--     end,
--   })
-- end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- Set up completion using nvim_cmp with LSP source
nvim_lsp.flow.setup({
  on_attach = on_attach,
})

nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
})

nvim_lsp.sourcekit.setup({
  on_attach = on_attach,
})

nvim_lsp.lua_ls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- enable_format_on_save(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  update_in_insert = false,
  virtual_text = false,
  loclist = false,
  -- virtual_text = { spacing = 5, prefix = "●" },
  severity_sort = true,
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 251

local opts = {
  noremap = true,
  silent = true
}

local keymap = vim.api.nvim_set_keymap
keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
keymap('i', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })
