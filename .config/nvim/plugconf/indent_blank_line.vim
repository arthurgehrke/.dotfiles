lua << EOF
vim.opt.list = true

vim.opt.fillchars = {
  -- Characters to be used in various user-interface elements.
  stl = ' ', -- Status-line of the current window.
  stlnc = ' ', -- Status-line of the non-current windows.
  vert = ' ', -- Vertical separator to be used with :vsplit.
  fold = ' ', -- Character to be used with 'foldtext'.
  diff = '╱', -- Deleted lines of the 'diff' option.
  msgsep = '─', -- Message separator for 'display' option.
  eob = ' ', -- Empty lines at the end of a buffer.
}

local highlight = {
  "Whitespace",
}

require("ibl").setup({
  indent = {
    char = '┊',
    highlight = highlight,
  },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  exclude = {
    buftypes = { "terminal", "nofile" },
    filetypes = {
      "alpha",
      "log",
      "gitcommit",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "dapui_breakpoints",
      "dapui_hover",
      "LuaTree",
      "dbui",
      "UltestSummary",
      "UltestOutput",
      "vimwiki",
      "markdown",
      -- "json",
      -- "txt",
      "vista",
      "NvimTree",
      "git",
      "TelescopePrompt",
      "undotree",
      "flutterToolsOutline",
      "org",
      "orgagenda",
      "help",
      "startify",
      "dashboard",
      "lazy",
      "neogitstatus",
      "Outline",
      "Trouble",
      "lspinfo",
      "", -- for all buffers without a file type
    },
  },
  scope = {
    enabled = false,
  },
})
EOF
