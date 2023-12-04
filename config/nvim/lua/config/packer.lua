-- TODO: some navigation like: https://github.com/SmiteshP/nvim-navbuddy

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'

    use({
      "neanias/everforest-nvim",
      config = function()
        require("everforest").setup {
          background = "medium", -- medium is default
        }
        vim.cmd [[colorscheme everforest]]
      end,
    })

    use 'benmills/vimux'       -- running command in tmux
    use 'tpope/vim-fugitive'   -- the ultimate git helper
    use 'tpope/vim-unimpaired'
    use 'ryanoasis/vim-devicons'
    use 'dyng/ctrlsf.vim'
    use 'tpope/vim-abolish'    -- " TODO: add it to <leader> so it's easier to find
    use 'tpope/vim-repeat'     --  # TODO: do we need it? most probably yes
    use 'edkolev/tmuxline.vim' -- TODO: generates powerline.conf for tmux from airline
    use 'christoomey/vim-tmux-navigator'
    use 'tmux-plugins/vim-tmux-focus-events'
    use 'vim-scripts/autoswap.vim'
    use 'moll/vim-bbye' -- :Db
    use 'kana/vim-textobj-user'
    use 'kana/vim-textobj-line'
    use 'michaeljsmith/vim-indent-object'
    use 'dzeban/vim-log-syntax'
    use 'embear/vim-foldsearch'
    use 'dimasg/vim-mark'
    use 'wsdjeg/vim-fetch'     -- Open some/file:line:column
    use 'plasticboy/vim-markdown'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
              mappings = { basic = false, extra = false },
            }
        end
    }

    use {
        'folke/which-key.nvim', -- awesome plugin to show available commands
        config = function() require("which-key").setup {} end
    }

    use {
      -- before lspconfig
      "folke/neodev.nvim", -- superior support for neovim config files/plugins
      config = function() require("neodev").setup {} end
    }

    use {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig", },
      {
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
          "nvim-lua/plenary.nvim",
          "neovim/nvim-lspconfig",
        }
      },
      {
        "simrat39/rust-tools.nvim",
        requires = { "neovim/nvim-lspconfig", }
      },
      {
        "ray-x/lsp_signature.nvim",
        requires = "neovim/nvim-lspconfig"
      },
    }
    -- Visualize lsp progress
    use({
      "j-hui/fidget.nvim",
      config = function() require("fidget").setup() end
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
    -- use("nvim-lua/popup.nvim") -- TODO: is it needed ? telescope-ui-select is same?
    use("nvim-lua/plenary.nvim")

    use {
      {
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        config = require('config.plugin.telescope'),
      },
      'nvim-telescope/telescope-ui-select.nvim', -- integrate telescope as selector
      'JoseConseco/telescope_sessions_picker.nvim',
    }


    use {
      "nvim-treesitter/nvim-treesitter",
      use "HiPhish/rainbow-delimiters.nvim",
      use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
      },
      config = require('config.plugin.treesitter'),
    }

    use {
      "folke/trouble.nvim",
      requires = {
        "folke/todo-comments.nvim", -- non mandatory
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",    -- required by todo-comments
      },
      config = function()
        require("trouble").setup {}
        require("todo-comments").setup {}
      end,
      -- TODO: should be possible to use 'Todo.*' but somehow that does not work, bug?
      -- cmd = { 'Trouble', 'TodoTrouble' }, -- lazy load
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
          event_handlers = {
            {
              event = "file_opened",
              handler = function(file_path) require("neo-tree").close_all() end
            },
          }
        }
      end,
    }

    use {
      'Shatur/neovim-session-manager',
      config = function()
        require 'session_manager'.setup {
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
        require('ibl').setup({})
      end,
    }

    use {
      "RRethy/vim-illuminate",
      config = function()
        pcall(function()
          require('illuminate').configure {}
        end)
      end,
    }

    use {
        "sindrets/diffview.nvim",
        config = function() pcall(function()
            vim.cmd [[command! -nargs=* Dfo DiffviewOpen]]
            local actions = require("diffview.actions")
            require('diffview').setup {
                view = {
                    merge_tool = {
                        layout = "diff3_mixed",
                    }
                },
                keymaps = {
                    view = {
                      { "n", "\\", actions.toggle_files, { desc = "Toggle the file panel." } },
                    },
                    file_panel = {
                      { "n", "\\", actions.toggle_files, { desc = "Toggle the file panel." } },
                    },
                    file_history_panel = {
                      { "n", "\\", actions.toggle_files, { desc = "Toggle the file panel." } },
                    }
                },
            } end)
        end,
    }

    use {
      -- tasks
      'stevearc/overseer.nvim',
      config = function() pcall(function() require('overseer').setup() end) end,
      requires = {
        {"nvim-telescope/telescope.nvim", }, -- for menus
        {"stevearc/dressing.nvim", }, -- otherwise telescope does not work properly
        {"rcarriga/nvim-notify", opt=true}, -- nicer notifications
      }
    }
    use {
      -- Nicer vim.ui.select and vim.ui.input
      'stevearc/dressing.nvim'
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
