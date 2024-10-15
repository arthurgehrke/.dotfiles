return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>mm',
      function()
        require('conform').format({ async = false, lsp_fallback = true, timeout_ms = 1000 })
      end,
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      bash = { 'shellharden', 'beautysh' },
      markdown = { 'textlint', 'marksman' },
      sh = { 'shellharden', 'beautysh' },
      zsh = { 'shellharden', 'beautysh' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
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
      yaml = { 'yamlfix', 'yamlfix' },
      psql = { 'sqlfluff' },
      rust = { 'rustfmt' },
      html = { 'htmlbeautifier' },
      css = { 'prettier', 'stylelint' },
      scss = { 'prettier', 'stylelint' },
      sass = { 'prettier', 'stylelint' },

      ['_'] = { 'trim_whitespace' },
    },
    quiet = true,
    formatters = {
      prettier = {
        condition = function(_, ctx)
          return vim.fs.find({
            '.prettierrc',
            '.prettierrc.json',
            '.prettierrc.yml',
            '.prettierrc.yaml',
            '.prettierrc.json5',
            '.prettierrc.js',
            '.prettierrc.cjs',
            '.prettierrc.mjs',
            '.prettierrc.toml',
            'prettier.config.js',
            'prettier.config.cjs',
            'prettier.config.mjs',
          }, { path = ctx.dirname, upward = true })[1] ~= nil
        end,
      },
      yamlfix = {
        command = 'local/path/yamlfix',
        env = {
          YAMLFIX_SEQUENCE_STYLE = 'block_style',
        },
      },
      injected = { options = { ignore_errors = true } },
    },
    notify_on_error = true,
    ignore_errors = true,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
