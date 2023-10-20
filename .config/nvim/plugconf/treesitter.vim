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

treesitter_config.setup {
  auto_install = true,
  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
  },
  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  -- ignore_install = { "javascript" },
  ignore_install = {},
  ensure_installed = {
    "xml",
    "http",
    "markdown",
    'markdown_inline',
    "jq",
    "json",
    "json5",
    "jsonc",
    "css",
    "html",
    "graphql",
    "lua",
    "luadoc",
    "typescript",
    "javascript",
    "tsx",
    "vim",
    "vimdoc",
    "python",
    "sql",
    "scss",
    "regex",
    "luap",
    "latex",
    "luau",
    "yaml",
    "gitcommit",
    "gitignore",
    "gitattributes",
    "dot",
    "diff",
    "dockerfile",
    "bash",
    "comment",
    'make',
    'git_rebase'
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

EOF

