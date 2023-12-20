local o = vim.opt

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
  pattern = '.env*',
  command = 'set filetype=conf',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'json', 'jsonc' },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
    desc = 'Fix conceallevel for json an help files',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'Navbuddy',
  },
  callback = function()
    vim.cmd([[
    nnoremap <silent> <buffer> q <cmd>close<CR>
    set nobuflisted
    ]])
  end,
  desc = 'Close some filetypes with <q>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*.py' },
    callback = function()
        vim.opt.foldmethod = 'indent'
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.linebreak = true
        vim.b.editorconfig = false
    end,
    desc = 'Set gitcommit config',
})
