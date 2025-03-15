local options = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>gp', function()
  local pattern = vim.fn.input('Search Regex: ')
  local filetype = vim.fn.input('File Glob: ')

  local cmd = string.format('vimgrep /%s/gj **/%s', pattern, filetype)

  vim.cmd(cmd)
  vim.cmd('copen')
end, { desc = 'Vimgrep for pattern & Glob' })

vim.keymap.set('n', '<leader>fd', '<cmd> Telescope diagnostics <CR>', { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>gt', '<cmd> Telescope git_status <CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>fw', '<cmd> Telescope live_grep <CR>', { desc = 'Live Grep' })

vim.keymap.set('n', '<leader>rl', ':%s/^$\\n*//<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'Floating Diagnostics' })

vim.keymap.set('n', '<leader>x', '<cmd> bd <CR>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader>X', '<cmd> bd! <CR>', { desc = 'Force Close Tab' })

-- Folding
vim.keymap.set('n', '<leader>fb', '$zf%', { desc = 'Fold block' })

-- Clear search with <esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', options)

vim.keymap.set('n', '<c-l>', ':bnext<cr>', options)
vim.keymap.set('n', '<c-h>', ':bprevious<cr>', options)

vim.keymap.set('i', 'jj', '<Esc>', options)
vim.keymap.set('i', 'jk', '<Esc>', options)

-- toggles relativenumber
vim.keymap.set('n', 'tt', ':set relativenumber!<CR>', options)

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', 'vv', '<C-w>v', options) -- split window vertically
vim.keymap.set('n', 'ss', '<C-w>s', options) -- split window horizontally
vim.keymap.set('n', 'sx', ':close<CR>', options)
vim.keymap.set('n', 'sd', ':bd<CR>', options)
vim.keymap.set('n', 'sq', ':close<CR>', options)
vim.keymap.set('n', 'tq', ':bd<cr>', options)
vim.keymap.set('n', 'sq', '<Cmd>quit<CR>', options)
vim.keymap.set('n', 'se', '<cmd>silent! %bdel|edit #|normal `"<C-n><leader>q<cr>', options)

vim.keymap.set('x', 'p', function()
  return 'pgv"' .. vim.v.register .. 'y'
end, { remap = false, expr = true })

-- vim.keymap.set("x", "p", '"_dP')
-- vim.keymap.set("x", "P", '"_dp')
vim.keymap.set('n', 'x', '"_x')

-- Insert empty line
vim.keymap.set('n', '<C-j>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>', options)
vim.keymap.set('n', '<C-k>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>', options)

vim.keymap.set('n', 'gvd', ':vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>', options)
vim.keymap.set('n', 'gsd', ':sp<CR><cmd>lua vim.lsp.buf.definition()<CR>', options)

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', 'sh', '<C-w>h', options)
vim.keymap.set('n', 'sj', '<C-w>j', options)
vim.keymap.set('n', 'sk', '<C-w>k', options)
vim.keymap.set('n', 'sl', '<C-w>l', options)

-- paths
-- Copy current path to clipboard
vim.keymap.set('n', '<Leader>cf', ':let @*=expand("%")<CR>', options)
-- Copy current file to clipboard
vim.keymap.set('n', '<Leader>ct', ':let @*=expand("%:t")<CR>', options)

-- indentation shifts keep selection(`=` should still be preferred)
vim.keymap.set('v', '<', '<gv', options)
vim.keymap.set('v', '>', '>gv', options)

-- POWERFULL SUBSTITUTION !!!
-- space s
-- highlight and replace all instances of the word under cursor
vim.keymap.set('n', '<leader>sw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--Disable highlights when cursor moved, enable then on n/N
vim.cmd([[autocmd cursormoved * set nohlsearch]])
vim.keymap.set('n', 'n', 'n:set hlsearch<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'N:set hlsearch<cr>', { noremap = true, silent = true })

local function next_conflict_marker()
  vim.fn.search('\\(<<<<<<<\\|=======\\|>>>>>>>\\)')
end

local function prev_conflict_marker()
  vim.fn.search('\\(<<<<<<<\\|=======\\|>>>>>>>\\)', 'b')
end

vim.keymap.set({ 'n', 'v' }, '[x', prev_conflict_marker)
vim.keymap.set({ 'n', 'v' }, ']x', next_conflict_marker)

-- change working directory
vim.keymap.set('n', '<leader>cd', '<cmd>:cd %:p:h<CR>:pwd<CR>', { silent = false })
-- Change this windows working directory to current dir and print it
vim.keymap.set('n', '<leader>cwd', '<cmd>lcd %:p:h<cr>:pwd<cr>', { silent = false })

local cmd = vim.api.nvim_create_user_command

-- Change working directory
cmd('Cwd', function()
  vim.cmd(':cd %:p:h')
  vim.cmd(':pwd')
end, { desc = 'cd current file\'s directory' })

cmd('Swd', function()
  vim.cmd(':cd %:p:h')
  vim.cmd(':pwd')
end, { desc = 'cd current file\'s directory' })

vim.keymap.set('n', '<leader>rr', ':%s/', { desc = 'Buffer search/replace' }, options)

vim.keymap.set('n', '<leader>od', function()
  vim.diagnostic.open_float(nil, {
    focus = false,
    scope = 'line',
  })
end, { desc = 'Show diagnostics for current line' })

vim.keymap.set('n', '<leader>dd', function()
  local cmd = 'disable'
  if vim.b.diagnostics_disabled == true then
    cmd = 'enable'
  end
  vim.b.diagnostics_disabled = not vim.b.diagnostics_disabled
  vim.diagnostic[cmd](0)
end, { buffer = bufnr })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>', opts)
vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>', opts)

vim.keymap.set('n', '<Leader>sq', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<Leader>d', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, opts)
    vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set(
      'n',
      'gq',
      '<cmd>lua vim.lsp.buf.format({ async = false, timeout_ms = 2000 })<CR>',
      { noremap = true, silent = true }
    )

    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    vim.keymap.set('n', '<leader>oi', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { 'source.organizeImports.ts' },
          diagnostics = {},
        },
      })
    end, opts)

    vim.keymap.set('n', 'ca', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { 'source.fixAll' },
        },
      })
    end, opts)
  end,

  vim.keymap.set('n', '<leader>gd', function()
    vim.lsp.buf.definition({
      on_list = function(list)
        vim.lsp.util.jump_to_location(list.items[1].user_data, 'utf-8', true)
      end,
    })
  end),
})

vim.keymap.set({ 'n', 'x' }, '<BS>', '%', { remap = true, desc = 'Jump to Paren' })
