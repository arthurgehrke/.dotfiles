return {
  'mfussenegger/nvim-lint',
  enabled = false,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      vue = { 'eslint_d' },
      python = { 'ruff' },
      php = { 'phpstan' },
      markdown = { 'vale' },
      go = { 'golangcilint' },
      lua = { 'luacheck' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      zsh = { 'shellcheck' },
      yaml = { 'yamllint' },
      json = { 'jsonlint' },
      sql = { 'sqlfluff' },
      html = { 'htmlhint' },
    }

    local eslint_d = lint.linters.eslint_d
    eslint_d.args = {
      '--no-warn-ignored',
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>lc', function()
      lint.try_lint()
    end, { desc = '[L]int [C]ode' })
  end,
}
