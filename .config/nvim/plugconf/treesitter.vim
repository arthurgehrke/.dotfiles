" TsBufEnable
lua << EOF
local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
  return
end

local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

require "nvim-treesitter.configs".setup {
  auto_install = true,
  highlight = {
    -- enable = not vim.g.vscode, -- false will disable the whole extension
    --  disable = function(lang, buf)
    --         local max_filesize = 100 * 1024 -- 100 KB
    --         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --         if ok and stats and stats.size > max_filesize then
    --             return true
    --         end
    --     end,

    enable = true,
    additional_vim_regex_highlighting = false -- <= THIS LINE is the magic!
  },
  indent = {
    enable = true,
    disable = {},
  },
  ignore_install = {},
  sync_install = false,
  ensure_installed = {
    "lua",
    "xml",
    "http",
    "typescript",
    "javascript",
    "tsx",
    "vim",
    "vimdoc",
    "python",
    "markdown_inline",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "sql",
    "scss",
    "css",
    "comment",
    "cmake",
    "c",
    "toml",
    "latex",
    "yaml",
    "toml",
    "gitcommit",
    "gitattributes",
    "csv",
    "gitignore",
    "gitattributes",
    "diff",
    "dockerfile",
    "bash",
    "comment",
    'make',
    'git_rebase',
    'r',
  },
  autotag = {
    enable = true,
    -- filetypes = {
    --   'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'xml', 'typescript', 'tsx'
    -- },
  },
  additional_vim_regex_highlighting = false,
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
EOF
