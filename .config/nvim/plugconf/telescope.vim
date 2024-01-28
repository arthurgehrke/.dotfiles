nnoremap ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <c-p> <cmd>Telescope find_files hidden=true<cr>
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

lua << EOF
local easypick = require("easypick")
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
      lsp_references = {
        theme = "dropdown",
        layout_config = {
          width = 0.6,
        },
      },
      lsp_document_symbols = {
        theme = "dropdown",
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

local base_branch = "production"
easypick.setup({
	pickers = {
		{
			name = "ls",
			command = "ls",
			previewer = easypick.previewers.default()
		},
		{
			name = "changed_files",
			command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
			previewer = easypick.previewers.branch_diff({base_branch = base_branch})
		},
		{
			name = "conflicts",
			command = "git diff --name-only --diff-filter=U --relative",
			previewer = easypick.previewers.file_diff()
		},
	}
})

vim.api.nvim_set_keymap('n', '<space>kk', ':Easypick<cr>', {noremap = true, silent = true})
EOF
