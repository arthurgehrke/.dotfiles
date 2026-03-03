local options = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>gp', function()
  local pattern = vim.fn.input('Search Regex: ')
  local filetype = vim.fn.input('File Glob: ')
  local cmd = string.format('vimgrep /%s/gj **/%s', pattern, filetype)
  vim.cmd(cmd)
  vim.cmd('copen')
end, { desc = 'Vimgrep for pattern & Glob' })

-- Telescope
vim.keymap.set('n', '<leader>fd', '<cmd> Telescope diagnostics <CR>', { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>gt', '<cmd> Telescope git_status <CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>fw', '<cmd> Telescope live_grep <CR>', { desc = 'Live Grep' })

-- Buffer & Tabs
vim.keymap.set('n', '<leader>x', '<cmd> bd <CR>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader>X', '<cmd> bd! <CR>', { desc = 'Force Close Tab' })
vim.keymap.set('n', '<c-l>', ':bnext<cr>', options)
vim.keymap.set('n', '<c-h>', ':bprevious<cr>', options)

-- Splits
vim.keymap.set('n', 'vv', '<C-w>v', options) -- split window vertically
vim.keymap.set('n', 'ss', '<C-w>s', options) -- split window horizontally
vim.keymap.set('n', 'sx', ':close<CR>', options)
vim.keymap.set('n', 'sd', ':bd<CR>', options)
vim.keymap.set('n', 'sq', ':close<CR>', options)
vim.keymap.set('n', 'tq', ':bd<cr>', options)
vim.keymap.set('n', 'se', '<cmd>silent! %bdel|edit #|normal `"<C-n><leader>q<cr>', options)

vim.keymap.set('n', 'sh', '<C-w>h', options)
vim.keymap.set('n', 'sj', '<C-w>j', options)
vim.keymap.set('n', 'sk', '<C-w>k', options)
vim.keymap.set('n', 'sl', '<C-w>l', options)

-- General Mappings
vim.keymap.set('n', '<leader>rl', ':%s/^$\\n*//<CR>', options)
vim.keymap.set('n', '<leader>fb', '$zf%', { desc = 'Fold block' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', options)
vim.keymap.set('i', 'jj', '<Esc>', options)
vim.keymap.set('i', 'jk', '<Esc>', options)
vim.keymap.set('n', 'tt', ':set relativenumber!<CR>', options)
vim.keymap.set('n', '<leader>w', ':set wrap! wrap?<CR>')
vim.keymap.set('n', '<leader>rr', ':%s/', { desc = 'Buffer search/replace' }, options)

-- Copy paths
vim.keymap.set('n', '<Leader>cf', ':let @*=expand("%")<CR>', options)
vim.keymap.set('n', '<Leader>ct', ':let @*=expand("%:t")<CR>', options)

-- Formatting / Indentation
vim.keymap.set('v', '<', '<gv', options)
vim.keymap.set('v', '>', '>gv', options)
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', '<C-j>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>', options)
vim.keymap.set('n', '<C-k>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>', options)

vim.keymap.set('x', 'p', function()
  return 'pgv"' .. vim.v.register .. 'y'
end, { remap = false, expr = true })

-- Search & Replace Word under cursor
vim.keymap.set('n', '<leader>sw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Search behaviors
vim.cmd([[autocmd cursormoved * set nohlsearch]])
vim.keymap.set('n', 'n', 'n:set hlsearch<cr>', options)
vim.keymap.set('n', 'N', 'N:set hlsearch<cr>', options)
vim.keymap.set({ 'n', 'v' }, ';', 'getcharsearch().forward ? \',\' : \';\'', { expr = true })
vim.keymap.set({ 'n', 'v' }, '\'', 'getcharsearch().forward ? \';\' : \',\'', { expr = true })

-- Conflict Markers
local function next_conflict_marker() vim.fn.search('\\(<<<<<<<\\|=======\\|>>>>>>>\\)') end
local function prev_conflict_marker() vim.fn.search('\\(<<<<<<<\\|=======\\|>>>>>>>\\)', 'b') end
vim.keymap.set({ 'n', 'v' }, '[x', prev_conflict_marker)
vim.keymap.set({ 'n', 'v' }, ']x', next_conflict_marker)

-- Directory navigation
vim.keymap.set('n', '<leader>cd', '<cmd>:cd %:p:h<CR>:pwd<CR>', { silent = false })
vim.keymap.set('n', '<leader>cwd', '<cmd>lcd %:p:h<cr>:pwd<cr>', { silent = false })

local cmd = vim.api.nvim_create_user_command
cmd('Cwd', function() vim.cmd(':cd %:p:h'); vim.cmd(':pwd') end, { desc = 'cd current file\'s directory' })
cmd('Swd', function() vim.cmd(':cd %:p:h'); vim.cmd(':pwd') end, { desc = 'cd current file\'s directory' })

-- Diagnostics (Native Neovim)
vim.keymap.set('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'Floating Diagnostics' })
vim.keymap.set('n', '<leader>od', function()
  vim.diagnostic.open_float(nil, { focus = false, scope = 'line' })
end, { desc = 'Show diagnostics for current line' })
vim.keymap.set('n', '<leader>dd', function()
  local toggle_cmd = vim.b.diagnostics_disabled and 'enable' or 'disable'
  vim.b.diagnostics_disabled = not vim.b.diagnostics_disabled
  vim.diagnostic[toggle_cmd](0)
end, { desc = 'Toggle diagnostics in buffer' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Go to previous error' })
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Go to next error' })
vim.keymap.set('n', '<Leader>sq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Misc
vim.keymap.set({ 'n', 'x' }, '<BS>', '%', { remap = true, desc = 'Jump to Paren' })
vim.keymap.set('n', 'q:', '<Nop>')
vim.keymap.set('n', 'q/', '<Nop>')
vim.keymap.set('n', 'q?', '<Nop>')
