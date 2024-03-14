vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  use({ 'echasnovski/mini.surround' })
  use({ 'nvimdev/hlsearch.nvim' })

  use('jalvesaq/Nvim-R')
  use('lukas-reineke/indent-blankline.nvim')
  use('rest-nvim/rest.nvim')
  use('b0o/schemastore.nvim')
  use('kristijanhusak/vim-dadbod-completion')
  use('kristijanhusak/vim-dadbod-ui')
  use('tpope/vim-dadbod')
  use({ 'mxsdev/nvim-dap-vscode-js', requires = { 'mfussenegger/nvim-dap' } })
  use('mhinz/vim-startify')
  use('nvim-lua/plenary.nvim')
  use('JoosepAlviste/nvim-ts-context-commentstring')

  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('pmizio/typescript-tools.nvim')

  use('stevearc/conform.nvim')

  use('WhoIsSethDaniel/mason-tool-installer.nvim')
  use('jay-babu/mason-nvim-dap.nvim')

  use({ 'RubixDev/mason-update-all' })
  use('neovim/nvim-lspconfig')

  use({
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
  })

  use({ 'nvim-treesitter/nvim-treesitter' })

  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
  })

  use('folke/lsp-trouble.nvim')

  use('mfussenegger/nvim-dap')
  use('theHamsta/nvim-dap-virtual-text')
  use('rcarriga/nvim-dap-ui')

  use('dstein64/vim-startuptime')

  use('sindrets/diffview.nvim')

  use('numToStr/Comment.nvim')

  use('akinsho/bufferline.nvim')

  use('nvim-lua/popup.nvim')

  use({ 'tpope/vim-fugitive' })
  use({ 'tpope/vim-rhubarb' })
  use({ 'shumphrey/fugitive-gitlab.vim' })

  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-symbols.nvim' },
    },
  })

  use({ 'ellisonleao/gruvbox.nvim' })
  use({ 'nvim-lualine/lualine.nvim' })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
