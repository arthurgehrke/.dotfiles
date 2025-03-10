local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
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

-- Unlist quickfist buffers
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Unlist quickfist buffers',
  group = augroup('unlist_quickfist', { clear = true }),
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- auto recon filetypes
local filetypes = {
  { ext = '*.json', type = 'json' },
  { ext = '*.py', type = 'python' },
  { ext = '*.lua', type = 'lua' },
  { ext = '*.md', type = 'markdown' },
  { ext = '*.js', type = 'javascript' },
  { ext = '*.ts', type = 'typescript' },
  { ext = '*.html', type = 'html' },
  { ext = '*.css', type = 'css' },
  { ext = '*.sh', type = 'sh' },
  { ext = '*.go', type = 'go' },
  { ext = '*.rs', type = 'rust' },
}

-- Iterar sobre a tabela para criar autocmds para cada extensão
for _, ft in ipairs(filetypes) do
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = ft.ext,
    command = 'set filetype=' .. ft.type,
  })
end
