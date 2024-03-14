local options = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- prevent unwanted paste buffer fills from delete char
vim.keymap.set('x', 'p', '"_dP')
vim.keymap.set('x', 'P', '"_dp')
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set('n', 'dw', 'vb"_d')
vim.keymap.set('n', 'cw', 'vb"_c')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')

vim.keymap.set('', '<C-r>', ':filetype detect<CR>', { silent = true })
vim.keymap.set('i', '<C-r>', '<Esc>:filetype detect<CR>a', { silent = true })

-- Keep the cursor in place while joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('n', '<c-l>', ':bnext<cr>', options)
vim.keymap.set('n', '<c-h>', ':bprevious<cr>', options)

vim.keymap.set('n', '*', '*zz', options)

vim.keymap.set('i', 'jj', '<Esc>', options)
vim.keymap.set('i', 'jk', '<Esc>', options)

-- Change split orientation
vim.keymap.set('n', '<leader>tk', '<C-w>t<C-w>K', options) -- change vertical to horizontal
vim.keymap.set('n', '<leader>th', '<C-w>t<C-w>H', options) -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', 'sh', '<C-w>h', options)
vim.keymap.set('n', 'sj', '<C-w>j', options)
vim.keymap.set('n', 'sk', '<C-w>k', options)
vim.keymap.set('n', 'sl', '<C-w>l', options)

-- toggles relativenumber
vim.keymap.set('n', '<leader>st', ':set relativenumber!<CR>', options)

vim.keymap.set('n', 'vv', '<C-w>v', options) -- split window vertically
vim.keymap.set('n', 'ss', '<C-w>s', options) -- split window horizontally
vim.keymap.set('n', 'sx', ':close<CR>', options)
vim.keymap.set('n', 'sd', ':bd<CR>', options)
vim.keymap.set('n', '<leader>s', '<cmd>update<cr>', options)
vim.keymap.set('n', 'sq', '<Cmd>quit<CR>', options)
vim.keymap.set('n', 'se', '<cmd>silent! %bdel|edit #|normal `"<C-n><leader>q<cr>', options)
vim.keymap.set('n', 'sQ', '<Cmd>tabc<CR>', options)

-- Insert empty line
vim.keymap.set('n', '<C-j>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>', { silent = true })

-- paths
-- Copy current path to clipboard
vim.keymap.set('n', '<Leader>cf', ':let @*=expand("%")<CR>', options)
-- Copy current file to clipboard
vim.keymap.set('n', '<Leader>ct', ':let @*=expand("%:t")<CR>', options)

vim.cmd([[command! BufOnly execute '%bdelete|edit #|normal `"']])

-- indentation shifts keep selection(`=` should still be preferred)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- plugins
-- diffview
vim.keymap.set('n', '<leader>gvo', '<Cmd>DiffviewOpen<CR>', options)
vim.keymap.set('n', '<leader>gl', '<Cmd>DiffviewFileHistory %<CR>', options)
vim.keymap.set('n', '<leader>gL', '<Cmd>DiffviewFileHistory<CR>', options)
vim.keymap.set('n', '<leader>gvq', '<Cmd>DiffviewClose<CR>', options)

-- NvimTree
vim.keymap.set('n', '<leader>f', vim.cmd.NvimTreeToggle, options)
vim.keymap.set('n', '<leader>r', vim.cmd.NvimTreeRefresh, options)

vim.keymap.set('n', '<leader>bo', '<cmd>%bd|e#<cr>', options) -- https://stackoverflow.com/a/42071865/516188
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, options)

-- formatter
vim.keymap.set('n', '<leader>aa', '<Cmd>Format<CR>', { desc = 'Format file' })
vim.keymap.set('v', '<leader>aa', '<Cmd>Format<CR>', { desc = 'Format visual selection' })

-- diffview
vim.keymap.set('n', '<leader>td', vim.cmd.Gvdiffsplit, { desc = 'git: diff split vertically ' })
vim.keymap.set('n', '<leader>zs', vim.cmd.Git, { desc = 'Git Status' })

-- fugitive
vim.keymap.set('n', '<space>gd', '<esc>:Gvdiff<space>')
-- Gvdiff get from left split
vim.keymap.set('n', 'fdh', ':diffget //2')
-- Gvdiff get from right split
vim.keymap.set('n', 'fdl', ':diffget //3')

local function next_conflict_marker()
  vim.fn.search("\\(<<<<<<<\\|=======\\|>>>>>>>\\)")
end

local function prev_conflict_marker()
  vim.fn.search("\\(<<<<<<<\\|=======\\|>>>>>>>\\)", "b")
end

vim.keymap.set({ "n", "v" }, "[x", prev_conflict_marker)
vim.keymap.set({ "n", "v" }, "x]", next_conflict_marker)

-- Telescope
-- vim.keymap.set('n', 'ff', '<cmd>Telescope find_files hidden=true<cr>', options)
vim.keymap.set('n', 'ff', function()
  require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
end)

vim.keymap.set('n', '<leader>;', ":lua require('telescope').extensions.live_grep_args.live_grep_args() <CR>", options)
vim.keymap.set('n', '<c-p>', '<cmd>Telescope live_grep<cr>', options)
-- vim.keymap.set("n", "<leader>;", ":Telescope live_grep<CR>", options)
vim.keymap.set('n', '<leader>gs', ":execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>", options)
-- open file_browser with the path of the current buffer
vim.keymap.set('n', '<space>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', options)

-- Buffer search/replace
vim.keymap.set('n', '<leader>sr', ':%s/', { desc = 'Buffer search/replace' })

-- ignores capital-typos when you want to write/quit
vim.cmd('command! WQ wq')
vim.cmd('command! Wq wq')
vim.cmd('command! W w')
vim.cmd('command! Q q')

