-- install packer automatically on new system
-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

vim.cmd [[
  augroup packer_sync_plugins
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return require('packer').startup {
  function(use)
    -- Polyglot loads language support on demand!
    use 'sheerun/vim-polyglot'
    -- Colors
    use 'morhetz/gruvbox'

    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        require "rs.statusline"
      end,
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
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

    -- use git within vim
    use 'tpope/vim-fugitive'
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

    -- fuzzy finder
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/plenary.nvim'},
        {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
        {"BurntSushi/ripgrep"},
      }
    }
    --use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
    --language support
    use "neovim/nvim-lspconfig"
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
      },
      config = function()
        require "rs.completion"
      end,
    }

    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
}
