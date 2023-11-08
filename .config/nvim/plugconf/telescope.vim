nnoremap ff <cmd>Telescope find_files hidden=true<cr>
nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap ft <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <expr> fF ':Telescope find_files<cr>' . expand('<cword>')
nnoremap <space>; <cmd> :Telescope live_grep hidden=true<CR>
nnoremap fr <cmd>Telescope live_grep_raw<cr>
nnoremap <expr><space>gs ':Telescope live_grep hidden=true<cr>' . expand('<cword>')
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap fs <cmd>Telescope grep_string<cr>
nnoremap <expr> fS ':Telescope grep_string<cr>' . expand('<cword>')
nnoremap <space>fq <cmd>Telescope quickfix<cr>
nnoremap <space>fi <cmd>Telescope loclist<cr>
nnoremap <space>fj <cmd>Telescope jumplist<cr>
nnoremap <space>fhl <cmd>Telescope highlights<cr>

nnoremap <space>fg <cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>
nnoremap <space>fq <cmd>Telescope quickfix<cr>
" Open/close the quickfix list
nnoremap <space>fib <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <space>qo :copen<CR>
nnoremap <space>qc :cclose<CR>

lua << EOF
local actions = require("telescope.actions")

require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "tmp",
      "node_modules",
      ".git/",
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    }, 
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
      '--hidden',
      '--multiline'
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
      spell_suggest = {
        theme = "cursor",
      }
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
vim.keymap.set("n", "<space>sx", require("telescope.builtin").resume, {
  noremap = true,
  silent = true,
  desc = "Resume",
})

     vim.api.nvim_create_autocmd("WinLeave", {
        callback = function()
          if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            if vim.fn.mode() == "i" then
              vim.schedule(function()
                vim.cmd("stopinsert")
              end)
            end
          end
        end,
      })
require'telescope'.load_extension('project')
require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('git_diffs')
EOF
