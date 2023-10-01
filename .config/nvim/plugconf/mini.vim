lua << EOF
require('mini.indentscope').setup({
  -- symbol = '│',
  symbol = '│',
  options = { try_as_border = true },
  -- symbol = '╎',
  -- symbol = '.',
  symbol = '·',
  mappings = {
    -- Textobjects
    object_scope = 'ii',
    object_scope_with_border = 'ai',

    -- Motions (jump to respective border line; if not present - body line)
    goto_top = '[i',
    goto_bottom = ']i',
  },
  draw = {
  animation = require('mini.indentscope').gen_animation.none(),
  },
})


require('mini.align').setup()

require('mini.jump2d').setup({
  mappings = {
    start_jumping = 's',
  },
  allowed_lines = {
    blank = false,
    cursor_before = true, -- Lines before cursor line
    cursor_at = true, -- Cursor line
    cursor_after = true, -- Lines after cursor line
    fold = false, -- Start of fold (not sent to spotter even if `true`)
  },
  allowed_windows = {
    current = true,
    not_current = false
  }
})

require('mini.sessions').setup({
  directory = '~/.local/share/nvim/session', -- for global sessions
  file = '', -- disable local sessions
})

EOF

