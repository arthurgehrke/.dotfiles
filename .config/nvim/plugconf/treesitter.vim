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
    enable = not vim.g.vscode, -- false will disable the whole extension
     disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
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
    "angular",
    "toml",
    "regex",
    "latex",
    "yaml",
    "toml",
    "gitcommit",
    "gitattributes",
    "csv",
    "gitignore",
    "gitattributes",
    "dot",
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
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  additional_vim_regex_highlighting = false,
}

require('ts_context_commentstring').setup {}
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

EOF
