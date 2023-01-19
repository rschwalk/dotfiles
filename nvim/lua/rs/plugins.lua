-- install packer automatically on new system
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  -- Polyglot loads language support on demand!
  use 'sheerun/vim-polyglot'
  -- Colors
  use 'morhetz/gruvbox'
  use 'shaunsingh/solarized.nvim'
  use "RRethy/nvim-base16"
  use "EdenEast/nightfox.nvim"
use 'Mofiqul/dracula.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require "rs.statusline"
    end,
    -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- VimWiki
  use 'vimwiki/vimwiki'

  -- use git within vim
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  -- compare directories
  use 'will133/vim-dirdiff'
  -- finishing caracter pars eg. "", (), [] some smart ways
  use 'Raimondi/delimitMate'
  -- change sorrounding characters
  use 'tpope/vim-surround'
  -- see searches during typing
  use 'wincent/loupe'
  -- C/C++ switch between .h and .cpp
  use 'derekwyatt/vim-fswitch'
  -- C/C++ pull definitions from header files
  use 'derekwyatt/vim-protodef'
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
      {"BurntSushi/ripgrep"},
      {"sharkdp/fd"},
    },
    config = function()
      require "rs.telescope"
    end
  }
  --language support
  use {"neovim/nvim-lspconfig",
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    }
  }
  use {
    'simrat39/rust-tools.nvim'
    --config = function()
      --  require('rust-tools').setup({})
    --end
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "ray-x/cmp-treesitter" },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "Saecki/crates.nvim" },
      { "f3fora/cmp-spell" },
      { "hrsh7th/cmp-cmdline" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
      require "rs.completion"
    end
  }
  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = '%:p' --vim.fn.expand '$MYVIMRC',
})

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

