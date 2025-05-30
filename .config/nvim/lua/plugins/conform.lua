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
      formatters_by_ft = {
        bash = { 'shfmt', 'shellharden', 'beautysh', stop_after_first = true },
        sh = { 'shfmt', 'shellharden', 'beautysh', stop_after_first = true },
        markdown = { 'textlint', 'marksman', stop_after_first = true },
        zsh = { 'shellharden', 'beautysh', stop_after_first = true },
        lua = { 'stylua' },
        python = { 'black', stop_after_first = true },
        go = { 'goimports', 'gofumpt' },
        sql = { 'sql_formatter' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        ['javascript.jsx'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['typescript.jsx'] = { 'prettierd', 'prettier', stop_after_first = true },
        ts = { 'prettierd', 'prettier', stop_after_first = true },
        tsx = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'jq', 'prettierd', 'prettier', stop_after_first = true },
        jsonc = { 'jq', 'prettierd', 'prettier', stop_after_first = true },
        json5 = { 'jq', 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'yamlfix' },
        psql = { 'sqlfluff' },
        rust = { 'rustfmt' },
        html = { 'htmlbeautifier' },
        css = { 'prettier', 'stylelint', stop_after_first = true },
        scss = { 'prettier', 'stylelint' },
        sass = { 'prettier', 'stylelint' },

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
    vim.o.formatexpr = 'v:lua.require\'conform\'.formatexpr()'
  end,
}
