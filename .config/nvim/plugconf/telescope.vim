nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap ft <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <expr> fF ':Telescope find_files<cr>' . expand('<cword>')
nnoremap <space>; <cmd>Telescope live_grep<cr>
nnoremap fr <cmd>Telescope live_grep_raw<cr>
nnoremap <expr><space>gs ':Telescope live_grep<cr>' . expand('<cword>')
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap fs <cmd>Telescope grep_string<cr>
nnoremap <expr> fS ':Telescope grep_string<cr>' . expand('<cword>')

lua << EOF
local actions = require("telescope.actions")

require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "tmp",
      "node_modules"
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-u'
      },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    }, 
  }
}
EOF
