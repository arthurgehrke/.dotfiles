return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      'mm',
      function()
        require('conform').format({ async = false, lsp_format = 'fallback', timeout_ms = 1000 })
      end,
      desc = 'Format buffer',
    },
  },
  config = function()
    require('conform').setup({
      formatters = {
        custom_stylua = {
          command = 'stylua',
          args = {
            '--respect-ignores',
            '--stdin-filepath',
            '$FILENAME',
            '--config-path',
            vim.fn.stdpath('config') .. '/.stylua.toml',
            '-',
          },
        },
      },
      formatters_by_ft = {
        bash = { 'shfmt', 'shellharden', 'beautysh', stop_after_first = true },
        sh = { 'shfmt', 'shellharden', 'beautysh', stop_after_first = true },
        zsh = { 'shfmt', 'shellharden', 'beautysh', stop_after_first = true },
        markdown = { 'prettier' },
        lua = { 'custom_stylua' },
        python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
        go = { 'goimports', 'gofumpt' },
        sql = { 'sql-formatter' },
        psql = { 'sqlfluff' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        json5 = { 'prettier' },
        yaml = { 'yamlfix' },
        rust = { 'rustfmt' },
        html = { 'htmlbeautifier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        sass = { 'prettier' },
        ['_'] = { 'trim_whitespace' },
      },
    })
    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format({ async = true, lsp_format = 'fallback', range = range })
    end, { range = true })
    require('conform').formatters.shfmt = {
      prepend_args = function(self, ctx)
        return { '-i', '2' }
      end,
    }
  end,
  init = function()
    vim.o.formatexpr = 'v:lua.require(\'conform\').formatexpr()'
  end,
}
