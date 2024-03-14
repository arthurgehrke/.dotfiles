vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>')
vim.keymap.set('n', '<leader>gf', '<cmd>DiffviewFileHistory %<cr>')
vim.keymap.set('n', '<leader>gF', '<cmd>DiffviewFileHistory<cr>')
vim.keymap.set('x', '<leader>gf', ":'<,'>DiffviewFileHistory<cr>")

vim.keymap.set('n', '<leader>oc', ":DiffviewClose<CR>", { desc = 'Diffview Close' })
vim.keymap.set('n', '<leader>of', ":DiffviewOpen<CR>", { desc = 'Diffview Open' })
vim.keymap.set('n', '<leader>oh', ":DiffviewOpen HEAD<CR>", { desc = 'Diffview Open -- HEAD' })
-- vim.keymap.set('n', '<leader>om', ":DiffviewOpen origin/main<CR>", { desc = 'Diffview Open -- origin/main' })
vim.keymap.set('n', '<leader>om', ":DiffviewOpen origin/development<CR>", { desc = 'Diffview Open -- origin/development' })
vim.keymap.set('n', '<leader>oo', ":DiffviewOpen ", { desc = 'Diffview Open against revision (enter prompt)' })

vim.keymap.set('n', '<leader>do', ":windo diffoff<CR>")
vim.keymap.set('n', '<leader>db', ":windo diffthis<CR>")
vim.keymap.set('n', '<leader>du', ":diffupdate<CR>")
vim.keymap.set('n', '<leader>dp', ":diffput<CR>")
vim.keymap.set('n', '<leader>dg', ":diffget<CR>")

require('diffview').setup({
  se_icons = false,
  file_panel = {
    listing_style = 'tree',
    win_config = {
      position = 'bottom',
      height = 10,
    },
    tree_options = {
      flatten_dirs = false,
      folder_statuses = 'only_folded',
    },
  },
})
