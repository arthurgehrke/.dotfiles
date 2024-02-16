lua << EOF
vim.opt.updatetime = 100
vim.opt.fileencoding = "utf-8"

-- vim.diagnostic.config({
--   virtual_text = false,
--   signs = true,
--   update_in_insert = false,
--   underline = true,
--   float = { border = 'none' },
--   severity_sort = true,
-- })

vim.g.diagnostics_visible = true

vim.keymap.set({ "n" }, "<A-|>", "<cmd>split<cr><C-w>j", { desc = "Horizontal Split" })
vim.keymap.set({ "n" }, "<A-\\>", "<cmd>vsplit<cr><C-w>l", { desc = "Vertical Split" })

vim.keymap.set({ "n" }, "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set({ "n" }, "]B", "<cmd>blast<cr>", { desc = "Last buffer" })
vim.keymap.set({ "n" }, "[b", "<cmd>bprev<cr>", { desc = "Prev buffer" })
vim.keymap.set({ "n" }, "[B", "<cmd>bfirst<cr>", { desc = "First buffer" })

vim.keymap.set({ "n" }, "[U", "<cmd>cfirst<cr>", { desc = "First quickfix item" })
vim.keymap.set({ "n" }, "<leader>q", "<cmd>confirm qall<cr>", { desc = "Quit" })
EOF

augroup NoHLSearch
  au!

  autocmd CursorHold,CursorMoved * call <SID>NoHLAfter(3)
augroup END

function! s:NoHLAfter(n)
  if !exists('g:nohl_starttime')
    let g:nohl_starttime = localtime()
  else
    if v:hlsearch && (localtime() - g:nohl_starttime) >= a:n
      set nohlsearch
      unlet g:nohl_starttime
    endif
  endif
endfunction
