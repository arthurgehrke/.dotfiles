lua << EOF
require('mini.indentscope').setup({
  symbol = '│',
  options = { try_as_border = true },
  symbol = '·',
  mappings = {
    object_scope = 'ii',
    object_scope_with_border = 'ai',
    goto_top = '[i',
    goto_bottom = ']i',
  },
  draw = {
  animation = require('mini.indentscope').gen_animation.none(),
  },
})

require('mini.sessions').setup({
  directory = '~/.local/share/nvim/session', 
  file = '',
})

require('mini.bufremove').setup()
require('mini.ai').setup({
  search_method = 'cover'
})
EOF

