return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    init = function()
      local highlight = function(bufnr, lang)
        if not vim.treesitter.language.add(lang) then
          return vim.notify(
            string.format('Treesitter cannot load parser for language: %s', lang),
            vim.log.levels.INFO,
            { title = 'Treesitter' }
          )
        end
        vim.treesitter.start(bufnr)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo.filetype
          local bt = vim.bo.buftype
          local buf = args.buf

          if bt ~= '' then
            return
          end

          local treesitter = require('nvim-treesitter')

          if not vim.tbl_contains({ 'python', 'html', 'yaml', 'markdown' }, ft) then
            vim.bo.indentexpr = 'v:lua.require(\'nvim-treesitter\').indentexpr()'
          end

          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end

          if vim.list_contains(treesitter.get_installed(), lang) then
            highlight(buf, lang)
          elseif vim.list_contains(treesitter.get_available(), lang) then
            treesitter.install(lang):await(function()
              highlight(buf, lang)
            end)
          end
        end,
      })
    end,
    opts = {
      install = {
        'bash',
        'c',
        'css',
        'dockerfile',
        'git_config',
        'gitcommit',
        'html',
        'javascript',
        'json',
        'json5',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'python',
        'query',
        'r',
        'rnoweb',
        'regex',
        'ruby',
        'rust',
        'scss',
        'sql',
        'ssh_config',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
        'go',
        'vue',
        'angular',
      },
    },
    config = function(_, opts)
      local treesitter = require('nvim-treesitter')
      treesitter.setup(opts)
      treesitter.install(opts.install)
    end,
  },
}
