local options = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- prevent unwanted paste buffer fills from delete char
vim.keymap.set('n', 'x', '"_x')

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Show search results while keeping the cursor in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set('n', '<c-l>', ':bnext<cr>', options)
vim.keymap.set('n', '<c-h>', ':bprevious<cr>', options)

vim.keymap.set('n', '*', '*zz', options)

vim.keymap.set('n', '<ESC>', ':nohlsearch<Bar>:echo<CR>', options)

vim.keymap.set("i", "jj", "<Esc>", options)
vim.keymap.set("i", "jk", "<Esc>", options)

-- Change split orientation
vim.keymap.set('n', '<leader>tk', '<C-w>t<C-w>K', options) -- change vertical to horizontal
vim.keymap.set('n', '<leader>th', '<C-w>t<C-w>H', options) -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', 'sh', '<C-w>h', options)
vim.keymap.set('n', 'sj', '<C-w>j', options)
vim.keymap.set('n', 'sk>', '<C-w>k', options)
vim.keymap.set('n', 'sl', '<C-w>l', options)

-- toggles relativenumber
vim.keymap.set("n", "<leader>st", ":set relativenumber!<CR>", options)

vim.keymap.set("n", "vv", "<C-w>v", options) -- split window vertically
vim.keymap.set("n", "ss", "<C-w>s", options) -- split window horizontally
vim.keymap.set("n", "sx", ":close<CR>", options)
vim.keymap.set("n", "sd", ":bd<CR>", options)

-- Insert empty line
vim.keymap.set("n", "<C-j>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>", { silent = true })

-- paths
-- Copy current path to clipboard
vim.keymap.set("n", "<Leader>cf", ':let @*=expand("%")<CR>', options)
-- Copy current file to clipboard
vim.keymap.set("n", "<Leader>ct", ':let @*=expand("%:t")<CR>', options)

vim.cmd [[command! BufOnly execute '%bdelete|edit #|normal `"']]

-- plugins
-- diffview
vim.keymap.set('n', '<leader>gvo', '<Cmd>DiffviewOpen<CR>', options)
vim.keymap.set('n', '<leader>gl', '<Cmd>DiffviewFileHistory %<CR>', options)
vim.keymap.set('n', '<leader>gL', '<Cmd>DiffviewFileHistory<CR>', options)
vim.keymap.set('n', '<leader>gvq', '<Cmd>DiffviewClose<CR>', options)

-- NvimTree
vim.keymap.set('n', '<leader>f', vim.cmd.NvimTreeToggle, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', vim.cmd.NvimTreeRefresh, { noremap = true, silent = true })

-- lsp
vim.keymap.set("n", "<space>bo", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" }) -- https://stackoverflow.com/a/42071865/516188
vim.keymap.set("n", "gvd", ":vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gsd", ":sp<CR><cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>od", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("v", "<leader>gq", vim.lsp.buf.format, { noremap = true, silent = true })

-- formatter
vim.keymap.set("n", "<leader>aa", "<Cmd>Format<CR>", { desc = "Format file" })
vim.keymap.set("v", "<leader>aa", "<Cmd>Format<CR>", { desc = "Format visual selection" })

-- easypick
vim.api.nvim_set_keymap('n', '<space>kk', ':Easypick<cr>', { noremap = true, silent = true })

-- diffview
vim.keymap.set("n", "<space>td", vim.cmd.Gvdiffsplit, { desc = "git: diff split vertically " })
vim.keymap.set("n", "<space>zs", vim.cmd.Git, { desc = "Git Status" })

-- fugitive
vim.keymap.set('n', '<space>gd', '<esc>:Gvdiff<space>')
-- Gvdiff get from left split
vim.keymap.set('n', 'fdh', ':diffget //2')
-- Gvdiff get from right split
vim.keymap.set('n', 'fdl', ':diffget //3')

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], options)

-- Telescope
vim.keymap.set("n", "ff", ":Telescope find_files hidden=true no_ignore=true hidden=true<CR>", options)
vim.keymap.set("n", "<leader>;", ":Telescope live_grep<CR>", options)
vim.keymap.set("n", "<leader>gs", ":execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>", options)

-- ignores capital-typos when you want to write/quit
vim.cmd "command! WQ wq"
vim.cmd "command! Wq wq"
vim.cmd "command! W w"
vim.cmd "command! Q q"

-- FUNCTIONS
-- Convert rows of space separated values to a tuple
function ToTuple()
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"

  -- add single quotes at the start and end of each line
  vim.cmd('silent execute "' .. start_line .. "," .. end_line .. "s/^/'/\"")
  vim.cmd('silent execute "' .. start_line .. "," .. end_line .. "s/$/',/\"")

  -- join all lines into a single line
  vim.cmd('silent execute "' .. start_line .. "," .. end_line .. 'join"')

  -- add parentheses at the start and end of the line
  vim.cmd "normal I("
  vim.cmd "normal $xa)"
end

function CleanTrailingWhitespaces()
  vim.cmd "%s/\\s\\+$//e"
end

vim.api.nvim_set_keymap("n", "<leader>x", ":lua CleanTrailingWhitespaces()<CR>", { noremap = true, silent = true })

function DisableSyntaxTreesitter()
  if vim.fn.exists ":TSBufDisable" then
    vim.cmd "TSBufDisable autotag"
    vim.cmd "TSBufDisable highlight"
    vim.cmd "TSBufDisable incremental_selection"
    vim.cmd "TSBufDisable indent"
    vim.cmd "TSBufDisable playground"
    vim.cmd "TSBufDisable query_linter"
    vim.cmd "TSBufDisable rainbow"
    vim.cmd "TSBufDisable refactor.highlight_definitions"
    vim.cmd "TSBufDisable refactor.navigation"
    vim.cmd "TSBufDisable refactor.smart_rename"
    vim.cmd "TSBufDisable refactor.highlight_current_scope"
    vim.cmd "TSBufDisable textobjects.swap"
    -- vim.cmd('TSBufDisable textobjects.move')
    vim.cmd "TSBufDisable textobjects.lsp_interop"
    vim.cmd "TSBufDisable textobjects.select"
  end

  vim.opt.foldmethod = "manual"
end

-- NOTE: it doesn't work with BufReadPre event
vim.api.nvim_create_autocmd({ "BufRead", "FileReadPre" }, {
  pattern = { "*" },
  callback = function()
    -- if file is larger than 512 KiB
    if vim.fn.getfsize(vim.fn.expand "%:p") > 512 * 1024 then
      DisableSyntaxTreesitter()
    end
  end,
})
