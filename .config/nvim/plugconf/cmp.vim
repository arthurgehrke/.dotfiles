lua << EOF
local cmp = require "cmp"

require("cmp").setup({
    {
        preselect = cmp.PreselectMode.None,
        window = {
            documentation = {
                documentation = cmp.config.window.bordered()
            }
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        },
        formatting = {
          fields = {'menu', 'abbr', 'kind'},
          format = function(entry, item)
          local menu_icon = {
            nvim_lsp = 'λ',
            luasnip = '⋗',
            buffer = 'Ω',
            path = '🖫',
          }

          item.menu = menu_icon[entry.source.name]
          return item
          end,
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
                ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
                ["<CR>"] = cmp.mapping.confirm({select = true}),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["q"] = cmp.mapping.abort()
            }
        ),
        sources = cmp.config.sources({
                {name = 'path'},
                {name = 'nvim_lsp', keyword_length = 1},
                {name = 'buffer', keyword_length = 3}
        })
})

function setAutoCmp(mode)
    if mode then
        cmp.setup({
          completion = {
              autocomplete = {require("cmp.types").cmp.TriggerEvent.TextChanged}
          }
        })
    else
        cmp.setup({
          completion = {
              autocomplete = false
          }
      })
    end
end

setAutoCmp(false)

-- enable automatic completion popup on typing
vim.cmd("command! AutoCmpOn lua setAutoCmp(true)")
-- disable automatic competion popup on typing
vim.cmd("command! AutoCmpOff lua setAutoCmp(false)")
EOF
