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
