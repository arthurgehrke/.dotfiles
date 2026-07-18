return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      'mm',
      function()
        require('conform').format({ async = false, lsp_fallback = true, timeout_ms = 1000 })
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
        global_prettier = {
          command = 'prettier',
          args = {
            '--stdin-filepath',
            '$FILENAME',
            '--config',
            vim.fn.stdpath('config') .. '/prettierrc.json',
            '--log-level',
            'silent',
          },
        },
      },
      formatters_by_ft = {
        bash = { 'shfmt', 'shellharden', 'beautysh', stop_after_first = true },
        sh = { 'shfmt', 'shellharden', 'beautysh', stop_after_first = true },
        zsh = { 'shfmt', 'shellharden', 'beautysh', stop_after_first = true },
        markdown = { 'global_prettier' },
        lua = { 'custom_stylua' },
        python = { 'black', stop_after_first = true },
        go = { 'goimports', 'gofumpt' },
        sql = { 'sql-formatter' },
        psql = { 'sqlfluff' },
        javascript = { 'global_prettier' },
        typescript = { 'global_prettier' },
        javascriptreact = { 'global_prettier' },
        typescriptreact = { 'global_prettier' },
        json = { 'jq', 'global_prettier', stop_after_first = true },
        jsonc = { 'jq', 'global_prettier', stop_after_first = true },
        json5 = { 'jq', 'global_prettier', stop_after_first = true },
        yaml = { 'yamlfix' },
        rust = { 'rustfmt' },
        html = { 'htmlbeautifier' },
        css = { 'global_prettier', 'stylelint', stop_after_first = true },
        scss = { 'global_prettier', 'stylelint', stop_after_first = true },
        sass = { 'global_prettier', 'stylelint', stop_after_first = true },
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
