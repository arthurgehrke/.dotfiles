nnoremap <space>ff <cmd>Telescope find_files<cr>
nnoremap <space>fg <cmd>Telescope live_grep<cr>
nnoremap <space>fb <cmd>Telescope buffers<cr>
nnoremap <space>fh <cmd>Telescope help_tags<cr>
nnoremap <space>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <space>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>

lua << END
local actions = require("telescope.actions")
require("telescope").setup({
defaults = {
  file_sorter = require("telescope.sorters").get_fzy_sorter,
  
  file_ignore_patterns = {
    "node_modules/**", 
    "^.git", 
    "**/package-lock.json",
    "**/LICENSE",
    "**/license",
    "**/yarn.lock",
    },
  prompt_prefix = " >",
  color_devicons = true,
  mappings = {
    i = {
      ["jk"] = actions.close,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    },
  },
  pickers = {
    buffers = {
        sort_lastused = true,
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
  },
  use_less = true,
  selection_strategy = "reset",
  sorting_strategy = "descending",
  set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  path_display = {"smart"},
  file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
  grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
  qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
extensions = {
  fzy_native = {
    override_generic_sorter = false,
    override_file_sorter = true,
    },
  },
})

require("telescope").load_extension("fzy_native")
END
