return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-nvim-lua' },
  },
  config = function()
    local cmp = require('cmp')
    local select_opts = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      completion = {
        autocomplete = false,
      },
      window = {
        completion = cmp.config.window.bordered(),
      },
      sources = {
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- ['<CR>'] = cmp.mapping({
        --   i = function(fallback)
        --     if cmp.visible() and cmp.get_selected_entry() then
        --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        --     else
        --       fallback()
        --     end
        --   end,
        --   s = cmp.mapping.confirm({ select = true }),
        --   c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        -- }),
      }),
    })
  end,
}
