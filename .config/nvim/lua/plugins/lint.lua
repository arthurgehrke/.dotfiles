return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    local eslint = lint.linters.eslint_d
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'ruff' },
      php = { 'phpstan' },
      markdown = { 'markdownlint' },
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

    lint.linters.eslint_d = require('lint.util').wrap(lint.linters.eslint_d, function(diagnostic)
      -- try to ignore "No ESLint configuration found" error
      -- if diagnostic.message:find("Error: No ESLint configuration found") then -- old version
      -- update: 20240814, following is working
      if diagnostic.message:find('Error: Could not find config file') then
        return nil
      end
      return diagnostic
    end)

    local try_lint = function()
      lint.try_lint()
    end

    -- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    --   group = lint_augroup,
    --   callback = try_lint,
    -- })

    vim.keymap.set('n', '<leader>lc', try_lint, { desc = '[L]int [C]ode' })
  end,
}
