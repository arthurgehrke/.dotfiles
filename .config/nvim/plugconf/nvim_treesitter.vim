lua << EOF
require'nvim-treesitter.configs'.setup {
  sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
  ensure_installed = {
    "markdown",
    "tsx",
    "php",
    "json",
    "tsx",
    "yaml",
    "css",
    "html",
    "lua",
    "typescript",
    "javascript",
    "vim"
  },
  autotag = {
    enable = true,
  },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
EOF
