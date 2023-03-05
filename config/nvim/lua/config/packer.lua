local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.g.neo_tree_remove_legacy_commands = 1

return require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'

  use 'lifepillar/vim-gruvbox8'
  use 'benmills/vimux' -- running command in tmux
  use 'tpope/vim-fugitive' -- the ultimate git helper
  use 'tpope/vim-commentary' -- comment/uncomment lines with gcc or gc in visual mode
  use 'vim-airline/vim-airline' -- status line
  use {'rhysd/vim-clang-format', ft = {'c', 'cpp'} }
  use 'tpope/vim-unimpaired'
  use 'ryanoasis/vim-devicons'
  use 'dyng/ctrlsf.vim'
  use 'tpope/vim-abolish' -- " TODO: add it to <leader> so it's easier to find
  use 'tpope/vim-repeat' -- " this is required by easyclip  # TODO: do we need it? most probably yes
  use 'edkolev/tmuxline.vim'
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-dispatch'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'vim-scripts/autoswap.vim'
  use 'moll/vim-bbye' -- :Db
  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-line'
  use 'michaeljsmith/vim-indent-object'
  use 'terryma/vim-expand-region'
  use 'dzeban/vim-log-syntax'
  use 'embear/vim-foldsearch'
  use 'dimasg/vim-mark'
  use 'wsdjeg/vim-fetch' -- Open some/file:line:column
  use 'mhinz/vim-startify'
  use 'dense-analysis/ale'
  use 'sheerun/vim-polyglot' -- a lot of filetypes
  use 'plasticboy/vim-markdown'

-- Utilitaries {{{
  use 'vim-scripts/CharTab' -- <leader>ct  character tab # TODO: lazy load
  use 'mechatroner/rainbow_csv' -- TODO: lazy load
  use 'dhruvasagar/vim-table-mode' -- TODO: lazy load
  use 'folke/which-key.nvim' -- awesome plugin to show available commands
-- }}}
-- " Considered for deletion {{{
-- Plug 'kana/vim-operator-user' " TODO: most probably not needed
-- " }}}


  use {
    "neovim/nvim-lspconfig",
     -- config = require("config.lsp")
  }
  -- Visualize lsp progress
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  })
  -- Autocompletion framework
  use("hrsh7th/nvim-cmp")
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
  -- See hrsh7th other plugins for more great completion sources!
  -- Snippet engine
  use('hrsh7th/vim-vsnip')
  -- Adds extra functionality over rust analyzer
  use("simrat39/rust-tools.nvim")

  -- Optional
  use("nvim-lua/popup.nvim") -- TODO: is it needed ? telescope-ui-select is same?
  use("nvim-lua/plenary.nvim")

  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
  }


  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-treesitter/nvim-treesitter",
  }
  -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- maybe not needed?
  use('nvim-telescope/telescope-ui-select.nvim')
  -- TODO: https://github.com/nvim-telescope/telescope-fzy-native.nvim

  use "williamboman/mason.nvim" -- builds

  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = require('config.plugin.gitsigns')
  }

  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,

  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "none" })
      end,
    },
  },
})

