require('conform').setup({
  log_level = vim.log.levels.ERROR,
  lang_to_ext = {
    bash = "sh",
    c_sharp = "cs",
    elixir = "exs",
    javascript = "js",
    julia = "jl",
    latex = "tex",
    markdown = "md",
    python = "py",
    ruby = "rb",
    rust = "rs",
    teal = "tl",
    typescript = "ts",
  },
  formatters_by_ft = {
    sh = { 'shfmt' },
    python = { 'isort', 'black' },
    sql = { 'sql_formatter' },
    lua = { 'stylua' },
    js = { 'prettier' },
    javascript = { 'prettier', 'prettierd' },
    typescript = { 'prettier', 'prettierd' },
    javascriptreact = { 'prettier', 'prettierd' },
    typescriptreact = { 'prettier', 'prettierd' },
    ['javascript.jsx'] = { 'prettier', 'prettierd' },
    ['typescript.jsx'] = { 'prettier', 'prettierd' },
    ts = { 'prettier', 'prettierd' },
    tsx = { 'prettier', 'prettierd' },
    vue = { 'prettier', 'prettierd' },

    -- JSON/XML
    json = { 'jq' },
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
