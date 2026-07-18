return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.opt.laststatus = 3
    vim.opt.showmode = false
    vim.opt.showcmd = false
  end,
  opts = function()
    local colors = {
      bg = '#222222',
      black = '#1c1c1c',
      grey = '#666666',
      red = '#685742',
      green = '#5f875f',
      yellow = '#B36D43',
      blue = '#78824B',
      magenta = '#bb7744',
      cyan = '#C9A554',
      white = '#D7C483',
      orange = '#d65d0e',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width_first = function()
        return vim.fn.winwidth(0) > 80
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 70
      end,
    }

    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.yellow,
      Rv = colors.yellow,
      cv = colors.yellow,
      ce = colors.yellow,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }

    -- cache de devicon por filetype: evita require + 2 lookups a cada redraw
    local icon_cache = {}
    local function get_icon()
      local ft = vim.bo.filetype
      if icon_cache[ft] ~= nil then
        return icon_cache[ft]
      end
      local ok, devicons = pcall(require, 'nvim-web-devicons')
      local icon = ''
      if ok then
        icon = devicons.get_icon(vim.fn.expand('%:t')) or devicons.get_icon_by_filetype(ft) or ''
      end
      icon_cache[ft] = icon:gsub('%s+', '')
      return icon_cache[ft]
    end

    local config = {
      options = {
        disabled_filetypes = {
          statusline = { 'NvimTree' },
          winbar = { 'NvimTree' },
        },
        component_separators = '',
        section_separators = '',
        globalstatus = true, -- combina com laststatus = 3
        refresh = { statusline = 200 }, -- 5 redraws/seg, suficiente
        theme = {
          normal = { c = { fg = colors.white, bg = 'NONE' } },
          insert = { c = { fg = colors.white, bg = 'NONE' } },
          visual = { c = { fg = colors.white, bg = 'NONE' } },
          replace = { c = { fg = colors.white, bg = 'NONE' } },
          command = { c = { fg = colors.white, bg = 'NONE' } },
          inactive = { c = { fg = colors.grey, bg = 'NONE' } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    local function L(c)
      table.insert(config.sections.lualine_c, c)
    end
    local function R(c)
      table.insert(config.sections.lualine_x, c)
    end
    local function IL(c)
      table.insert(config.inactive_sections.lualine_c, c)
    end
    local function IR(c)
      table.insert(config.inactive_sections.lualine_x, c)
    end

    L({
      get_icon,
      color = function()
        return { bg = mode_color[vim.fn.mode()], fg = colors.white }
      end,
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░' },
    })
    L({
      'filename',
      cond = conditions.buffer_not_empty,
      color = function()
        return { bg = mode_color[vim.fn.mode()], fg = colors.white }
      end,
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░' },
      symbols = { modified = '󰶻 ', readonly = ' ', unnamed = ' ', newfile = ' ' },
    })
    L({
      'branch',
      icon = '',
      color = { bg = colors.blue, fg = colors.black },
      padding = { left = 0, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    })

    R({
      function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ''
        end
        local names = {}
        for _, c in ipairs(clients) do
          names[#names + 1] = c.name
        end
        return table.concat(names, ', ')
      end,
      icon = ' ',
      color = { bg = colors.green, fg = colors.black },
      padding = { left = 1, right = 1 },
      cond = conditions.hide_in_width_first,
      separator = { right = '▓▒░', left = '░▒▓' },
    })
    R({
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      colored = false,
      color = { bg = colors.magenta, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    })
    R({
      'searchcount',
      color = { bg = colors.cyan, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    })
    R({
      'location',
      color = { bg = colors.red, fg = colors.white },
      padding = { left = 1, right = 0 },
      separator = { left = '░▒▓' },
    })
    R({
      'progress',
      color = { bg = colors.red, fg = colors.white },
      padding = { left = 1, right = 1 },
      cond = conditions.hide_in_width,
      separator = { right = '▓▒░' },
    })
    R({
      'o:encoding',
      fmt = string.upper,
      cond = conditions.hide_in_width,
      padding = { left = 1, right = 1 },
      color = { bg = colors.blue, fg = colors.black },
    })
    R({
      'fileformat',
      fmt = string.lower,
      icons_enabled = false,
      cond = conditions.hide_in_width,
      color = { bg = colors.blue, fg = colors.black },
      separator = { right = '▓▒░' },
      padding = { left = 0, right = 1 },
    })

    IL({
      function()
        return ''
      end,
      cond = conditions.buffer_not_empty,
      color = { bg = colors.black, fg = colors.grey },
      padding = { left = 1, right = 1 },
    })
    IL({
      'filename',
      cond = conditions.buffer_not_empty,
      color = { bg = colors.black, fg = colors.grey },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░' },
      symbols = { modified = '', readonly = '', unnamed = '', newfile = '' },
    })
    IR({
      'location',
      color = { bg = colors.black, fg = colors.grey },
      padding = { left = 1, right = 0 },
      separator = { left = '░▒▓' },
    })
    IR({
      'progress',
      color = { bg = colors.black, fg = colors.grey },
      cond = conditions.hide_in_width,
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░' },
    })
    IR({
      'fileformat',
      fmt = string.lower,
      icons_enabled = false,
      cond = conditions.hide_in_width,
      color = { bg = colors.black, fg = colors.grey },
      separator = { right = '▓▒░' },
      padding = { left = 0, right = 1 },
    })

    return config
  end,
}
