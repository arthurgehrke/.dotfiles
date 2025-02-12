return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    local eslint = lint.linters.eslint_d

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'ruff' },
      php = { 'phpstan' },
      markdown = { 'vale' },
    }

    eslint.args = {
      '--no-warn-ignored',
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    vim.keymap.set('n', '<leader>lc', function()
      lint.try_lint()
    end, { desc = '[L]int [C]ode' })
  end,
}
