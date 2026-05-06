return {
  'kevinhwang91/nvim-bqf',
  opts = {
    auto_enable = {
      description = [[Enable nvim-bqf in quickfix window automatically]],
      default = true,
    },
    magic_window = {
      description = [[Give the window magic, when the window is splited horizontally, keep
            the distance between the current line and the top/bottom border of neovim unchanged.
            It's a bit like a floating window, but the window is indeed a normal window, without
            any floating attributes.]],
      default = true,
    },
    auto_resize_height = {
      description = [[Resize quickfix window height automatically.
            Shrink higher height to size of list in quickfix window, otherwise extend height
            to size of list or to default height (10)]],
      default = false,
    },
    preview = {
      auto_preview = {
        description = [[Enable preview in quickfix window automatically]],
        default = true,
      },
      border = {
        description = [[The border for preview window,
                `:h nvim_open_win() | call search('border:')`]],
        default = 'rounded',
      },
      show_title = {
        description = [[Show the window title]],
        default = true,
      },
      show_scroll_bar = {
        description = [[Show the scroll bar]],
        default = true,
      },
      delay_syntax = {
        description = [[Delay time, to do syntax for previewed buffer, unit is millisecond]],
        default = 50,
      },
      win_height = {
        description = [[The height of preview window for horizontal layout,
                large value (like 999) perform preview window as a "full" mode]],
        default = 15,
      },
      win_vheight = {
        description = [[The height of preview window for vertical layout]],
        default = 15,
      },
      winblend = {
        description = [[The winblend for preview window, `:h winblend`]],
        default = 12,
      },
      wrap = {
        description = [[Wrap the line, `:h wrap` for detail]],
        default = false,
      },
      buf_label = {
        description = [[Add label of current item buffer at the end of the item line]],
        default = true,
      },
      should_preview_cb = {
        description = [[A callback function to decide whether to preview while switching buffer,
                with (bufnr: number, qwinid: number) parameters]],
        default = nil,
      },
    },
    func_map = {
      description = [[The table for {function = key}]],
      default = [[see ###Function table for detail]],
    },
    filter = {
      fzf = {
        action_for = {
          ['ctrl-t'] = {
            description = [[Press ctrl-t to open up the item in a new tab]],
            default = 'tabedit',
          },
          ['ctrl-v'] = {
            description = [[Press ctrl-v to open up the item in a new vertical split]],
            default = 'vsplit',
          },
          ['ctrl-x'] = {
            description = [[Press ctrl-x to open up the item in a new horizontal split]],
            default = 'split',
          },
          ['ctrl-q'] = {
            description = [[Press ctrl-q to toggle sign for the selected items]],
            default = 'signtoggle',
          },
          ['ctrl-c'] = {
            description = [[Press ctrl-c to close quickfix window and abort fzf]],
            default = 'closeall',
          },
        },
        extra_opts = {
          description = 'Extra options for fzf',
          default = { '--bind', 'ctrl-o:toggle-all' },
        },
      },
    },
  },
  config = function()
    vim.cmd([[
                hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
                hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
                hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
                hi link BqfPreviewRange Search
                hi default link BqfPreviewFloat Normal
                hi default link BqfPreviewBorder FloatBorder
                hi default link BqfPreviewTitle Title
                hi default link BqfPreviewThumb PmenuThumb
                hi default link BqfPreviewSbar PmenuSbar
                hi default link BqfPreviewCursor Cursor
                hi default link BqfPreviewCursorLine CursorLine
                hi default link BqfPreviewRange IncSearch
                hi default link BqfPreviewBufLabel BqfPreviewRange
                hi default BqfSign ctermfg=14 guifg=Cyan
                if exists('b:current_syntax')
                    finish
                endif

                syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
                syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
                syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
                syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
                syn match qfError / E .*$/ contained
                syn match qfWarning / W .*$/ contained
                syn match qfInfo / I .*$/ contained
                syn match qfNote / [NH] .*$/ contained

                hi def link qfFileName Directory
                hi def link qfSeparatorLeft Delimiter
                hi def link qfSeparatorRight Delimiter
                hi def link qfLineNr LineNr
                hi def link qfError DiagnosticError
                hi def link qfWarning DiagnosticWarn
                hi def link qfInfo DiagnosticInfo
                hi def link qfNote DiagnosticHint

                let b:current_syntax = 'qf'
]])

    require('bqf').setup({
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
        show_title = false,
        should_preview_cb = function(bufnr, _)
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            return false
          elseif bufname:match('^fugitive://') then
            return false
          end
          return true
        end,
      },
      func_map = {
        open = '<CR>',
        openc = 'O',
        drop = 'o',
        tabdrop = '<C-t>',
        tab = 't',
        tabb = 'T',
        tabc = '',
        split = '<C-s>',
        vsplit = '<C-v>',
        prevfile = '<C-p>',
        nextfile = '<C-n>',
        prevhist = '<',
        nexthist = '>',
        lastleave = '\'"',
        stoggleup = '<S-Tab>',
        stoggledown = '<Tab>',
        stogglevm = '<Tab>',
        stogglebuf = '\'<Tab>',
        sclear = 'z<Tab>',
        pscrollup = '<C-b>',
        pscrolldown = '<C-f>',
        pscrollorig = 'zo',
        ptogglemode = 'z,',
        ptoggleitem = 'p',
        ptoggleauto = 'P',
        filter = 'zn',
        filterr = 'zN',
        fzffilter = 'zf',
      },
      filter = {
        fzf = {
          action_for = { ['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop' },
          extra_opts = { '--bind', 'ctrl-o:toggle-all', '--delimiter', '│' },
        },
      },
    })

    local fn = vim.fn

    function _G.qftf(info)
      local items
      local ret = {}
      -- The name of item in list is based on the directory of quickfix window.
      -- Change the directory for quickfix window make the name of item shorter.
      -- It's a good opportunity to change current directory in quickfixtextfunc :)
      --
      -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
      -- local root = getRootByAlterBufnr(alterBufnr)
      -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
      --
      if info.quickfix == 1 then
        items = fn.getqflist({ id = info.id, items = 0 }).items
      else
        items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
      end
      local limit = 31
      local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
      local validFmt = '%s │%5d:%-3d│%s %s'
      for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
          if e.bufnr > 0 then
            fname = fn.bufname(e.bufnr)
            if fname == '' then
              fname = '[No Name]'
            else
              fname = fname:gsub('^' .. vim.env.HOME, '~')
            end
            -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
            if #fname <= limit then
              fname = fnameFmt1:format(fname)
            else
              fname = fnameFmt2:format(fname:sub(1 - limit))
            end
          end
          local lnum = e.lnum > 99999 and -1 or e.lnum
          local col = e.col > 999 and -1 or e.col
          local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
          str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
          str = e.text
        end
        table.insert(ret, str)
      end
      return ret
    end

    vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
  end,
}
