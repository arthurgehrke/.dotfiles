vim.g.skip_ts_context_commentstring_module = true

vim.filetype.add({
  filename = {
    ['.env'] = 'sh',
  },
  pattern = {
    ['%.env%..*'] = 'sh',
    ['.*%.env'] = 'sh',
  },
})

return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    main = 'ts_context_commentstring',
    opts = {
      enable_autocmd = false,
    },
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      local ft = require('Comment.ft')
      local ts_pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()

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
        pre_hook = function(ctx)
          local ok, result = pcall(ts_pre_hook, ctx)
          if ok and result and result ~= '' then
            return result
          end
          local cs = vim.bo.commentstring
          if cs and cs ~= '' then
            return cs
          end
          return '#%s'
        end,
      })

      ft.set('sh', '#%s')
      ft.set('bash', '#%s')
      ft.set('zsh', '#%s')
      ft.set('conf', '#%s')
      ft.set('config', '#%s')
      ft.set('dotenv', '#%s')

      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { '.env', '.env.*', '*.env' },
        callback = function()
          vim.bo.commentstring = '# %s'
        end,
      })
    end,
  },
}
