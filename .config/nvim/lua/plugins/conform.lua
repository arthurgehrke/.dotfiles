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
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      sql = { 'sql_formatter' },
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      ['javascript.jsx'] = { { 'prettierd', 'prettier' } },
      ['typescript.jsx'] = { { 'prettierd', 'prettier' } },
      ts = { { 'prettierd', 'prettier' } },
      tsx = { { 'prettierd', 'prettier' } },
      vue = { 'prettierd' },
      sh = { 'shfmt' },

      -- JSON/XML
      json = { { 'jq', 'prettierd', 'prettier' } },
      jsonc = { { 'prettierd', 'prettier' } },
      json5 = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },
      html = { 'htmlbeautifier' },
      zsh = { 'shellcheck' },

      css = { 'prettier', 'stylelint' },
      less = { 'prettier', 'stylelint' },
      scss = { 'prettier', 'stylelint' },
      sass = { 'prettier', 'stylelint' },

      ['_'] = { 'trim_whitespace' },
    },
    quiet = true,
    formatters = {
      injected = { options = { ignore_errors = true } },
      options = {
        shfmt = {
          prepend_args = { '-i', '2' },
        },
      },
    },
    notify_on_error = true,
    ignore_errors = true,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
