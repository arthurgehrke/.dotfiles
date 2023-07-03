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
  sync_install = false,
  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
  },
  indent = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
  },
  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  -- ignore_install = { "javascript" },
  ignore_install = {},
  auto_install = true,
  ensure_installed = {
    "markdown",
    "tsx",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "typescript",
    "javascript",
    "vim",
    "vimdoc",
    "sql",
    "yaml",
    "vim",
    "gitcommit",
    "dockerfile",
    "bash",
    'comment',
    'diff',
    'make',
    'markdown',
    'markdown_inline',
    'git_rebase'
  },
}
EOF

