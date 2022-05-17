lua << EOF
local nvim_lsp = require("lspconfig")

-- Needs: npm install -g typescript-language-server typescript
nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
  -- disable tsserver formatting if you plan on formatting via null-ls
  client.resolved_capabilities.document_formatting = false

  local ts_utils = require("nvim-lsp-ts-utils")

  local null_ls = require("null-ls")
  null_ls.setup({
      sources = {
          null_ls.builtins.diagnostics.eslint.with({
            prefer_local = "node_modules/.bin",
          }),
          null_ls.builtins.diagnostics.eslint, -- eslint or eslint_d
          null_ls.builtins.code_actions.eslint, -- eslint or eslint_d
      },
  })

  -- defaults
  ts_utils.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,
    import_all_timeout = 5000, -- ms
    import_all_priorities = {
      same_file = 1, -- add to existing import statement
      local_files = 2, -- git files or files with relative path markers
      buffer_content = 3, -- loaded buffer content
      buffers = 4, -- loaded buffer names
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,
    -- if false will avoid organizing imports
    always_organize_imports = false,

    -- eslint
    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    eslint_bin = "eslint",
    eslint_config_fallback = nil,
    eslint_enable_diagnostics = true,

    -- formatting
    enable_formatting = false,

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,
  }

  -- required to fix code action ranges
  ts_utils.setup_client(client)

  -- no default maps, so you may want to define some here
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>to", ":TSLspOrganize<CR>", {silent = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ti", ":TSLspImportAll<CR>:TSLspOrganize<CR>", {silent = true})
  end
}
EOF
