lua << EOF
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end
local function nmap(k, v) map('n', k, v) end
local function vmap(k, v) map('v', k, v) end
local function imap(k, v) map('i', k, v) end

vim.keymap.set("n", "<space>td", vim.cmd.Gvdiffsplit, { desc = "git: diff split vertically " })

vim.opt.diffopt = { -- Option settings for diff mode.
  'filler', -- Show filler lines.
  'vertical', -- Start diff mode with vertical splits.
  'hiddenoff', -- Do not use diff mode for a buffer when it becomes hidden.
  'foldcolumn:0', -- Set the 'foldcolumn' option to 0.
  'algorithm:histogram', -- Use the specified diff algorithm.
}

vim.g.nvim_tree_disable_netrw = 0
-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])


vim.keymap.set("n", "<space>zs", vim.cmd.Git, { desc = "Git Status" })

nmap('dp', 'dp]c')
nmap('do', 'do]c')
nmap('<space>wds', ':windo diffthis')
nmap('<space>wdo', ':windo diffoff')


  -- move to parent directory when exploring the tree
vim.cmd[[
  autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   vim.keymap_set( <buffer> <leader>.. :edit %:h<CR> |
  \ endif
]]

vim.cmd[[
  cnoreabbrev <expr> gg getcmdtype() == ":" && getcmdline() == 'gg' ? 'G ' : 'gg'
]]
-- Fugitive vertical diff
vim.keymap.set('n', '<space>gd', '<esc>:Gvdiff<space>')
-- Gvdiff get from left split
vim.keymap.set('n', 'fdh', ':diffget //2')
-- Gvdiff get from right split
vim.keymap.set('n', 'fdl', ':diffget //3')
EOF

command! DiffviewFile execute("DiffviewOpen -- " . expand("%")) | DiffviewToggleFiles

command! -nargs=? PreviousVersion diffthis |
      \ vnew |
      \ set buftype=nofile |
      \ set bufhidden=wipe |
      \ set noswapfile |
      \ execute "r!git show ".(!"<args>"?'head^':"<args>").":".expand('#') |
      \ 1d_ |
      \ let &filetype=getbufvar('#', '&filetype') |
      \ execute 'autocmd BufWipeout <buffer> diffoff!' |
      \ diffthis
