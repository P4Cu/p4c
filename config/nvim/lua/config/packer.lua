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

return require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'

  use {
    'sainnhe/gruvbox-material',
    config = function()
      vim.cmd [[ colorscheme gruvbox-material ]]
    end
  }

  use 'benmills/vimux' -- running command in tmux
  use 'tpope/vim-fugitive' -- the ultimate git helper
  use 'tpope/vim-commentary' -- comment/uncomment lines with gcc or gc in visual mode
  use 'tpope/vim-unimpaired'
  use 'ryanoasis/vim-devicons'
  use 'dyng/ctrlsf.vim'
  use 'tpope/vim-abolish' -- " TODO: add it to <leader> so it's easier to find
  use 'tpope/vim-repeat' --  # TODO: do we need it? most probably yes
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
  use 'sheerun/vim-polyglot' -- a lot of filetypes
  use 'plasticboy/vim-markdown'

  use 'folke/which-key.nvim' -- awesome plugin to show available commands


  use {
    { "williamboman/mason.nvim" },
    {
      "neovim/nvim-lspconfig",
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
      }
    },
    {
      "simrat39/rust-tools.nvim",
      requires = {
        "neovim/nvim-lspconfig",
      }
    },
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    }
    -- TODO: https://github.com/p00f/clangd_extensions.nvim
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

  -- Optional
  use("nvim-lua/popup.nvim") -- TODO: is it needed ? telescope-ui-select is same?
  use("nvim-lua/plenary.nvim")


  use {
    {
      "nvim-telescope/telescope.nvim",
      requires = "nvim-treesitter/nvim-treesitter",
      config = require('config.plugin.telescope'),
    },
    'nvim-telescope/telescope-ui-select.nvim', -- integrate telescope as selector
    'JoseConseco/telescope_sessions_picker.nvim',
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    use "HiPhish/nvim-ts-rainbow2",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "rust", "cpp" },
        highlight = {
          enable = true,
        },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
        rainbow = {
          enable = true,
          disable = {},
          query = 'rainbow-parens',
          -- Highlight the entire buffer all at once
          strategy = require 'ts-rainbow'.strategy.global,
        }
      }
    end,
  }

  use {
    "folke/trouble.nvim",
    requires = {
      "folke/todo-comments.nvim", -- non mandatory
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim", -- required by todo-comments
    },
    config = function()
      require("trouble").setup {}
      require("todo-comments").setup {}
    end,
    -- TODO: should be possible to use 'Todo.*' but somehow that does not work, bug?
    cmd = { 'Trouble', 'TodoTrouble' }, -- lazy load
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
    },
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      require('neo-tree').setup {
        filesystem = {
          follow_current_file = true,
        },
      }
    end,
  }

  use {
    'Shatur/neovim-session-manager',
      config = function ()
        require'session_manager'.setup {
          autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
          autosave_only_in_session = true,
        }
        -- no space after command is important as otherwise it fails
        vim.cmd [[command! Session SessionManager load_session]]
        vim.cmd [[command! SessionDelete SessionManager delete_session]]
        vim.cmd [[command! SessionSaveCurrent SessionManager save_current_session]]
      end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = require 'config.plugin.lualine',
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        show_current_context = true,
        space_char_blankline = " ",
      })
    end,
  }

  use "folke/neodev.nvim" -- superior support for neovim config files/plugins

  use {
    "RRethy/vim-illuminate",
    config = function()
      pcall(function()
        require('illuminate').configure {}
      end)
    end,
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
