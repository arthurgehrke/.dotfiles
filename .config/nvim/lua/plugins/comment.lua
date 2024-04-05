return {
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    event = 'BufEnter',
    lazy = true,
    keys = { 'go', 'gcc', { 'go', mode = 'v' }, { 'ggo', mode = 'v' } },
    opts = function(_, opts)
      -- default mappings:
      -- {
      --   toggler = {
      --     ---Line-comment toggle keymap
      --     line = 'gcc',
      --     ---Block-comment toggle keymap
      --     block = 'gbc',
      --   },
      --   ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      --   opleader = {
      --       ---Line-comment keymap
      --       line = 'gc',
      --       ---Block-comment keymap
      --       block = 'gb',
      --   },
      --   ---LHS of extra mappings
      --   extra = {
      --       ---Add comment on the line above
      --       above = 'gcO',
      --       ---Add comment on the line below
      --       below = 'gco',
      --       ---Add comment at the end of line
      --       eol = 'gcA',
      --   }
      -- }

      -- hack to not load ts_context_commentstring until actually needed by the hook
      local commentstring_avail, commentstring = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
      if commentstring_avail then
        opts.pre_hook = commentstring.create_pre_hook()
      end

      require('Comment').setup({
        padding = true,
        sticky = true,
        ignore = '^$',
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA',
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = function(...)
          if hook == nil then
            hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
          end
          hook(...)
        end,
      })
      require('Comment.ft').mysql = { '# %s', '/* %s */' }

      require('ts_context_commentstring').setup({
      })
    end,
  },
}
