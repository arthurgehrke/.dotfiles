-- return {--   'sainnhe/gruvbox-material',--   lazy = false, -- Isso garante que o tema seja carregado automaticamente--   priority = 1000, -- Prioridade alta para que o tema seja aplicado antes de outros plugins--   enabled = true,--   config = function()--     -- Configuração do Gruvbox Material--     vim.g.gruvbox_material_background = 'hard' -- Opções: 'soft', 'medium', 'hard'--     vim.g.gruvbox_material_foreground = 'material' -- Alterne entre 'material' e 'mix'--     vim.g.gruvbox_material_enable_italic = 1--     vim.g.gruvbox_material_enable_bold = 1--     vim.g.gruvbox_material_palette = 'material' -- Usa o esquema de cores material que é mais saturado--     vim.g.gruvbox_material_sign_column_background = 'none' -- Remove o fundo da coluna de sinalizadores--     vim.g.gruvbox_material_visual = 'reverse' -- Torna a seleção visual mais vívida--     vim.g.gruvbox_material_disable_italic_comment = 1--     vim.g.gruvbox_material_better_performance = 1 -- Para melhor desempenho--     -- Definir o esquema de cores--     vim.cmd('colorscheme gruvbox-material')--   end,-- }return {  'ellisonleao/gruvbox.nvim',  enabled = true,  lazy = false,  -- disable = true,  priority = 1000,  config = function()    require('gruvbox').setup({      terminal_colors = true,      undercurl = true,      underline = true,      bold = true,      italic = {        strings = false,        operators = false,        comments = false,      },      strikethrough = false,      invert_selection = false,      invert_signs = false,      invert_tabline = false,      invert_intend_guides = false,      inverse = true,      contrast = 'hard',      palette_overrides = {},      overrides = {},      dim_inactive = false,      transparent_mode = true,    })    vim.cmd('colorscheme gruvbox')  end,}