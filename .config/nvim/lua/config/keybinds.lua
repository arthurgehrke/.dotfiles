vim.g.mapleader = ' ';
vim.g.maplocalleader = ' ';

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('i', 'jk', '<Esc>')


-- vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
-- vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
-- vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
-- vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")

vim.keymap.set("n", "<C-h>", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<C-q>", ":bprevious<CR>:bdelete #<CR>", { silent = true })

-- vim.keymap.set("n", "ss", ":wa!<cr>", { desc = "(NaaVim) Buffer: Force Write everything" })
vim.keymap.set("n", "qq", ":wqa!<cr>", { desc = "(NaaVim) Buffer: Force Write and Quit everything" })

-- Manage splits
vim.keymap.set("n", "sv", ":vsplit<cr>", { desc = "(NaaVim) Buffer: Vertical Split" })
vim.keymap.set("n", "ss", ":split<cr>", { desc = "(NaaVim) Buffer: Horizontal Split" })
vim.keymap.set("n", "sx", ":close!<cr>", { desc = "(NaaVim) Buffer: Close Buffer" })
vim.keymap.set("n", "sq", ":bdelete!<cr>", { desc = "(NaaVim) Buffer: Quit Buffer" })

-- Buffer Manipulation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "(NaaVim) Buffer: Move Page up and stay in the Middle of the Screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "(NaaVim) Buffer: Move Page up and stay in the Middle of the Screen" })
vim.keymap.set("n", "<Leader>n", ":noh<cr>", { desc = "(NaaVim) Buffer: No Highlighting" })

-- Char Manipulation
vim.keymap.set("n", "x", '"_x', { desc = "(NaaVim) Chars: Delete Char without losing the Buffer" })
vim.keymap.set({ "n", "i" }, "<m-backspace>", "<c-w", { desc = "(NaaVim) Chars: Delete a Word with Backspace" })
vim.keymap.set("x", "p", '"_dP', { desc = "(NaaVim) Chars: Paste without losing the Buffer" })

-- Line Manipulation
vim.keymap.set("v", "<", "<gv", { desc = "(NaaVim) Line: Indent to Left" })
vim.keymap.set("v", ">", ">gv", { desc = "(NaaVim) Line: Indent to Right" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "(NaaVim) Line: Move in a Linebreak up" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "(NaaVim) Line: Move in a Linebreak down" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "(NaaVim) Line: Concat Line without moving the Cursor" })
