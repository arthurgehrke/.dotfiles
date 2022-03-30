lua << END

local ignore_these = {
  'node_modules/.*',
  '.yarn/.*',
  '.neuron/*',
  'fonts/*',
  'icons/*',
  'images/*',
  'dist/*',
  'build/*',
  'yarn.lock',
  'package%-lock.json',
  '.git/*'
}

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      '.git'
      },
     vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
    },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case"
      },
    },
  pickers = {
    find_files = {
      hidden = true,
      file_ignore_patterns = ignore_these,
    },
    live_grep = {
      file_ignore_patterns = ignore_these,
      },
    file_browser = {
      hidden = true,
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      -- theme = "dropdown",
      -- previewer = false,
      mappings = {
        i = {
          ["<M-d>"] = "delete_buffer",
          }
        }
      }
    }
  }
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
END

nnoremap <space>ff <cmd>Telescope find_files<cr>
nnoremap <space>fg <cmd>Telescope live_grep<cr>
nnoremap <space>ft :lua require('telescope.builtin').git_files()<CR>
nnoremap <space>fb <cmd>Telescope buffers<cr>
nnoremap <space>fh <cmd>Telescope help_tags<cr>
nnoremap <space>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <space>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>

