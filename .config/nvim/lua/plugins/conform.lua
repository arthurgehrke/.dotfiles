return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>mp',
      function()
        require('conform').format({ async = false, lsp_fallback = true, timeout_ms = 1000 })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      sql = { 'sql_formatter' },
      javascript = { 'prettierd' },
      typescript = { 'prettier', 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      ['javascript.jsx'] = { 'prettier' },
      ['typescript.jsx'] = { 'prettier' },
      ts = { 'prettierd' },
      tsx = { 'prettierd' },
      vue = { 'prettierd' },
      sh = { 'shfmt' },

      -- JSON/XML
      json = { 'prettierd' },
      jsonc = { 'prettierd' },
      json5 = { 'prettierd' },
      yaml = { 'prettierd' },
      html = { 'prettierd' },
      zsh = { 'shellcheck' },

      css = { 'prettier', 'stylelint' },
      less = { 'prettier', 'stylelint' },
      scss = { 'prettier', 'stylelint' },
      sass = { 'prettier', 'stylelint' },

      ['_'] = { 'trim_whitespace' },
    },
    quiet = true,
    -- Set up format-on-save
    -- format = { timeout_ms = 1000, async = false, quiet = true },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
    notify_on_error = true,
    ignore_errors = true,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
