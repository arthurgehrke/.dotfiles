----- Autocommands from LazyVim!
local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- -- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- go to last loc when opening a buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = augroup("last_loc"),
--   callback = function(event)
--     local exclude = { "gitcommit" }
--     local buf = event.buf
--     if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
--       return
--     end
--     vim.b[buf].lazyvim_last_loc = true
--     local mark = vim.api.nvim_buf_get_mark(buf, '"')
--     local lcount = vim.api.nvim_buf_line_count(buf)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

vim.cmd("filetype on")

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
  pattern = '.env*',
  command = 'set filetype=conf',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd('BufEnter', { command = [[set formatoptions-=cro]] })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Create missing directories on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('CreateMissingDirectoriesOnSave', {}),
  pattern = '*',
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- 7. Make q close help, man, quickfix, dap floats
vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Make q close help, man, quickfix, dap floats',
  group = augroup('q_close_windows', { clear = true }),
  callback = function(event)
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = event.buf })
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = event.buf })
    if buftype == 'nofile' or filetype == 'help' then
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true, nowait = true })
    end
  end,
})

-- 9. Unlist quickfist buffers
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Unlist quickfist buffers',
  group = augroup('unlist_quickfist', { clear = true }),
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
