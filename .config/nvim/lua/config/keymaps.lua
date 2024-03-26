local options = { noremap = true, silent = true }
-- Clear search with <esc>

vim.keymap.set('n', '<c-l>', ':bnext<cr>', options)
vim.keymap.set('n', '<c-h>', ':bprevious<cr>', options)

vim.keymap.set("i", "jj", "<Esc>", options)
vim.keymap.set("i", "jk", "<Esc>", options)

-- toggles relativenumber
vim.keymap.set("n", "<leader>st", ":set relativenumber!<CR>", options)

-- Move around splits using Ctrl + {h,j,k,l}

vim.keymap.set("n", "vv", "<C-w>v", options) -- split window vertically
vim.keymap.set("n", "ss", "<C-w>s", options) -- split window horizontally
vim.keymap.set("n", "sx", ":close<CR>", options)
vim.keymap.set("n", "sd", ":bd<CR>", options)
vim.keymap.set("n", "sq", "<Cmd>quit<CR>", options)
vim.keymap.set("n", "se", '<cmd>silent! %bdel|edit #|normal `"<C-n><leader>q<cr>', options)

-- Insert empty line
vim.keymap.set("n", "<C-j>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", options)
vim.keymap.set("n", "<C-k>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>", options)

vim.keymap.set("n", "gvd", ":vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gsd", ":sp<CR><cmd>lua vim.lsp.buf.definition()<CR>")

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', 'sh', '<C-w>h', options)
vim.keymap.set('n', 'sj', '<C-w>j', options)
vim.keymap.set('n', 'sk', '<C-w>k', options)
vim.keymap.set('n', 'sl', '<C-w>l', options)

-- paths
-- Copy current path to clipboard
vim.keymap.set("n", "<Leader>cf", ':let @*=expand("%")<CR>', options)
-- Copy current file to clipboard
vim.keymap.set("n", "<Leader>ct", ':let @*=expand("%:t")<CR>', options)

-- indentation shifts keep selection(`=` should still be preferred)
vim.keymap.set("v", "<", "<gv", options)
vim.keymap.set("v", ">", ">gv", options)

-- greatest remap ever
-- paste on highlited text 
-- without "auto-yanking" the overwritten text
-- allows pasting over and over 
-- without loosing the originally yanked text
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever
-- give the ability to yank into the system clipboard
-- (to only have it into vim's register yank without leader)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- NvimTree
--vim.keymap.set('n', '<leader>f', vim.cmd.NvimTreeToggle, options)
--vim.keymap.set('n', '<leader>r', vim.cmd.NvimTreeRefresh, options)

-- POWERFULL SUBSTITUTION !!!
-- space s
-- highlight and replace all instances of the word under cursor
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local function next_conflict_marker()
  vim.fn.search("\\(<<<<<<<\\|=======\\|>>>>>>>\\)")
end

local function prev_conflict_marker()
  vim.fn.search("\\(<<<<<<<\\|=======\\|>>>>>>>\\)", "b")
end

vim.keymap.set({ "n", "v" }, "[x", prev_conflict_marker)
vim.keymap.set({ "n", "v" }, "]x", next_conflict_marker)


-- Buffer search/replace
vim.keymap.set('n', '<leader>rr', ':%s/', { desc = 'Buffer search/replace' })

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>co', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>sq', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<Leader>d', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, opts)
    vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', 'gq', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))

    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'ca', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.fixAll" },
        },
      })
    end, opts)
  end,
})

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
