vim.g.startify_session_dir = "~/.config/nvim/.sessions"
vim.g.startify_change_to_vcs_root = true
vim.g.startify_change_to_dir = true
vim.g.startify_session_persistence = true
vim.g.startify_session_delete_buffers = true

-- function! s:gitModified()
--     let files = systemlist('git ls-files -m 2>/dev/null')
--     return map(files, "{'line': v:val, 'path': v:val}")
-- endfunction
-- " same as above, but show untracked files, honouring .gitignore
-- function! s:gitUntracked()
--     let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
--     return map(files, "{'line': v:val, 'path': v:val}")
-- endfunction

-- vim.g["startify_lists"] = {
--   { type = "dir",       header = { ("   Current Directory " .. vim.fn.getcwd()) } },
--       { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
--         { 'type': function('s:gitModified'),  'header': ['   git modified']},
--          { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
--   { type = "sessions",  header = { "   Sessions" } },
--   { type = "bookmarks", header = { "   Bookmarks" } },
--   { type = "files",     header = { "   Files" } },
-- }

vim.g["startify_bookmarks"] = {
  { i = "~/.config/nvim" },
  { p = "~/repositories/doare" },
}
