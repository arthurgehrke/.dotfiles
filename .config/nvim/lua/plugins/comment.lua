vim.g.skip_ts_context_commentstring_module = true

return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = false,
    opts = { enable_autocmd = false },
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      local ft = require('Comment.ft')
      require('Comment').setup({
        padding = true,
        sticky = true,
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          ---Line-comment keymap
          line = 'gc',
          ---Block-comment keymap
          block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
          above = 'gcO',
          ---Add comment on the line below
          below = 'gco',
          eol = 'gcA',
        },
        mappings = {
          basic = true,
          extra = true,
        },
        ignore = '^$', -- ignore empty lines
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        hook = function()
          require('ts_context_commentstring.internal').update_commentstring()
        end,
      })

      ft.set('dotenv', { '//%s', '/*%s*/' })
    end,
  },
}
