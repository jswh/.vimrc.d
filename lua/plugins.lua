return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { "ellisonleao/gruvbox.nvim" }
  use { 'preservim/nerdtree' }
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'nvim-tree/nvim-web-devicons'}
  use { 'nvim-treesitter/nvim-treesitter'}
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { "Pocco81/auto-save.nvim"}

  use {'williamboman/nvim-lsp-installer', 'neovim/nvim-lspconfig'}
  -- nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
  use 'hrsh7th/cmp-buffer'   -- { name = 'buffer' },
  use 'hrsh7th/cmp-path'     -- { name = 'path' }
  use 'hrsh7th/cmp-cmdline'  -- { name = 'cmdline' }
  use 'hrsh7th/nvim-cmp'
  -- vsnip
  use 'hrsh7th/cmp-vsnip'    -- { name = 'vsnip' }
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'
  -- lspkind
  use 'onsails/lspkind-nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use { "windwp/nvim-autopairs" }
  use { "windwp/nvim-ts-autotag" }
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'kamykn/spelunker.vim'
  use 'rmagatti/goto-preview'
  use 'voldikss/vim-floaterm'
  use 'gpanders/editorconfig.nvim'


end)

