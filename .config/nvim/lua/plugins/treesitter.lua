require "nvim-treesitter.configs".setup {
  highlight = {
    disable = function(lang, buf)
      local max_filesize = 2 * 1024 * 1024   -- 2 MB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false   -- <= THIS LINE is the magic!
  },
  indent = {
    enable = true,
    disable = {},
  },
  ignore_install = {},
  auto_install = true,
  sync_install = false,
  ensure_installed = {
    "markdown",
    "lua",
    "c_sharp",
    "xml",
    "http",
    "html",
    "typescript",
    "javascript",
    "tsx",
    "vim",
    "python",
    "json",
    "json5",
    "jsonc",
    "sql",
    "scss",
    "css",
    "latex",
    "yaml",
    "toml",
    "bash",
    'r',
  },
  autotag = {
    enable = true,
  },
  additional_vim_regex_highlighting = false,
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
