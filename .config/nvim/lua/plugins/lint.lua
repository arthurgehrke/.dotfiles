return {
  'mfussenegger/nvim-lint',
  enabled = true,
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

    -- eslint_d: pass file via stdin + stdin-filename
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

    -- Only run eslint_d if a known eslint config exists in the project.
    -- Avoids spurious errors in repos without eslint.
    local eslint_config_files = {
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.cjs',
      '.eslintrc.mjs',
      '.eslintrc.json',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      'eslint.config.js',
      'eslint.config.mjs',
      'eslint.config.cjs',
      'eslint.config.ts',
    }

    local function has_eslint_config()
      return #vim.fs.find(eslint_config_files, {
        upward = true,
        path = vim.fn.expand('%:p:h'),
        stop = vim.loop.os_homedir(),
      }) > 0
    end

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = lint_augroup,
      callback = function()
        local ft = vim.bo.filetype
        local linters = lint.linters_by_ft[ft]
        if not linters then
          return
        end
        -- Skip eslint_d if no config is found
        if vim.tbl_contains(linters, 'eslint_d') and not has_eslint_config() then
          return
        end
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>lc', function()
      lint.try_lint()
    end, { desc = '[L]int [C]ode' })
  end,
}
