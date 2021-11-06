let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }

let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }

let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
lua << EOF
require'nvim-tree'.setup {
  open_on_setup = true,
  open_on_tab = true,
  update_cwd = true,
  auto_close = true,
  diagnostics = {
    enable = false,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {}
  },
  view = {
    side = 'left',
    width = 40,
    auto_resize = true,
  },
}

require'nvim-tree.view'.View.winopts.relativenumber = false
require'nvim-tree.view'.View.winopts.number = false

local opts = {silent = true, noremap = true}
vim.api.nvim_set_keymap('n', '<Space>f', '<Cmd>NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<Space>r', '<Cmd>NvimTreeRefresh<CR>', opts)
vim.api.nvim_set_keymap('n', '<Space>c', '<Cmd>NvimTreeFindFile<CR>', opts)
EOF

highlight NvimTreeFolderIcon guibg=blue
" nnoremap <Space>f :NvimTreeToggle<CR>
" nnoremap <Space>r :NvimTreeRefresh<CR>
" nnoremap <Space>c :NvimTreeFindFile<CR>

set termguicolors 
highlight NvimTreeFolderIcon guibg=blue

