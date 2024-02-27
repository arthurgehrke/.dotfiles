local telescope = require("telescope")
local actions = require("telescope.actions")

require('telescope').setup{ 
  defaults = { 
    theme = "dropdown",
    prompt_prefix = " ❯ ",
    color_devicons = true,
    file_ignore_patterns = { 
      "tmp",
      "node_modules",
      ".git/**",
      "package%-lock.json",
      "yarn%-lock.json",
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    }, 
    vimgrep_arguments = {
      'rg',
      -- '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
      '--hidden',
      '--multiline'
    },
    preview = {
      treesitter = false
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
        theme = "dropdown",
      },
      live_grep = {
        theme = "dropdown",
        additional_args = function(opts)
        return {"--hidden"}
        end
      },
    },
    commands = {
      theme = "dropdown",
      sort_mru = true,
      sort_lastused = true,
    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = 'smart_case',       -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
      },
      file_browser = {
        respect_gitignore = false,
        select_buffer = true,
        grouped = true,
        auto_depth = true,
        cwd_to_path = true,
        path = '%:p:h',
        prompt_path = true,
        hijack_netrw = true,
      },
      git_diffs = {
        git_command = { "git", "log", "--oneline", "--decorate", "--all", "." } -- list result
      },
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('file_browser')
