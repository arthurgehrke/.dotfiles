lua <<EOF
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

alpha.setup(require'alpha.themes.startify'.config)
local dashboard = require("alpha.themes.dashboard")
dashboard.section.buttons.val = {
	dashboard.button("n", " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("s", " Settings", ":e ~/.config/nvim<CR>"),
	dashboard.button("q", " Quit", ":qa<CR>"),
}

EOF
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
