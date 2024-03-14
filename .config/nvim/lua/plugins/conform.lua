require('conform').setup({
  log_level = vim.log.levels.ERROR,
  formatters_by_ft = {
    sh = { 'shfmt' },
    python = { 'isort', 'black' },
    sql = { 'sql_formatter' },
    lua = { 'stylua' },
    astro = { 'prettierd' },
    js = { 'prettier' },
    cjs = { 'prettierd' },
    mjs = { 'prettierd' },
    javascript = { 'prettierd' },
    typescript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    ['javascript.jsx'] = { 'prettier' },
    ['typescript.jsx'] = { 'prettier' },
    ts = { 'prettierd' },
    tsx = { 'prettierd' },
    vue = { 'prettierd' },

    -- JSON/XML
    json = { 'prettier' },
    jsonc = { 'prettier' },
    json5 = { 'prettier' },
    yaml = { 'prettier' },
    ['yaml.docker-compose'] = { 'prettier' },
    html = { 'prettier' },

    -- Markdown
    markdown = { 'prettier' },
    ['markdown.mdx'] = { 'prettier' },

    -- CSS
    css = { 'prettier', 'stylelint' },
    less = { 'prettier', 'stylelint' },
    scss = { 'prettier', 'stylelint' },
    sass = { 'prettier', 'stylelint' },

    ['_'] = { 'trim_whitespace' },
  },
  formatters = {
    injected = { options = { ignore_errors = true } },
  },
  format = { timeout_ms = 500, async = false, quiet = true },
  notify_on_error = false,
})

vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
  require('conform').format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { silent = true, remap = true })
