return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  -- lazy = true,
  config = function()
    local lint = require('lint')

    require('lint').linters_by_ft = {
      javascript = { 'eslint', 'eslint_d' },
      typescript = { 'eslint', 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'pylint' },
      -- javascript = { 'eslint' },
      -- typescript = { 'eslint' },
      -- javascriptreact = { 'eslint' },
      -- typescriptreact = { 'eslint' },
      sh = { 'shellcheck' },
      css = { 'stylelint' },
      scss = { 'stylelint' },
      yaml = { 'yamllint' },
    }
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>rl', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}
