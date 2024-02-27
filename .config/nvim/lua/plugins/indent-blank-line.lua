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
