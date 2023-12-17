return {
    {
      "neanias/everforest-nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require("everforest").setup {
          background = "medium", -- medium is default
        }
        vim.cmd [[colorscheme everforest]]
      end,
    },

    -- maybe add https://github.com/folke/neoconf.nvim ??

    'benmills/vimux',       -- running command in tmux
    'tpope/vim-fugitive',   -- the ultimate git helper
    'tpope/vim-unimpaired',
    'ryanoasis/vim-devicons', -- TODO: only neotree?
    'dyng/ctrlsf.vim',
    'tpope/vim-abolish',    -- " TODO: add it to <leader> so it's easier to find
    'tpope/vim-repeat',     --  # TODO: do we need it? most probably yes
    'edkolev/tmuxline.vim', -- TODO: generates powerline.conf for tmux from airline
    'christoomey/vim-tmux-navigator',
    'tmux-plugins/vim-tmux-focus-events',
    'vim-scripts/autoswap.vim',
    'moll/vim-bbye', -- :Db
    {
        'kana/vim-textobj-line',
        dependencies = 'kana/vim-textobj-user',
    },
    {
        'michaeljsmith/vim-indent-object',
        dependencies = 'kana/vim-textobj-user',
    },
    'dzeban/vim-log-syntax',
    'embear/vim-foldsearch',
    'dimasg/vim-mark',
    'wsdjeg/vim-fetch',     -- Open some/file:line:column
    'plasticboy/vim-markdown',

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
              mappings = { basic = false, extra = false },
            }
        end
    },

    {
        'folke/which-key.nvim', -- awesome plugin to show available commands
        config = function() require("which-key").setup {} end
    },

    {
      "folke/trouble.nvim",
      dependencies = {
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
    },

        {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('ibl').setup({})
      end,
    },

    {
      "RRethy/vim-illuminate",
      config = function()
        pcall(function()
          require('illuminate').configure {}
        end)
      end,
    },

    {
      -- tasks
      'stevearc/overseer.nvim',
      config = function() pcall(function() require('overseer').setup() end) end,
      dependencies = {
        {"nvim-telescope/telescope.nvim", }, -- for menus
        {"stevearc/dressing.nvim", }, -- otherwise telescope does not work properly
        {"rcarriga/nvim-notify"}, -- nicer notifications
      }
    },
    -- Nicer vim.ui.select and vim.ui.input
    { "stevearc/dressing.nvim", event = "VeryLazy" },

    {'aklt/plantuml-syntax', ft='puml'}
}
