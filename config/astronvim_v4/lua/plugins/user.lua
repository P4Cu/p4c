-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip" (plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },

  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.nvim-autopairs" (plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --         -- don't add a pair if the next character is %
  --             :with_pair(cond.not_after_regex "%%")
  --         -- don't add a pair if  the previous character is xxx
  --             :with_pair(
  --               cond.not_before_regex("xxx", 3)
  --             )
  --         -- don't move right when repeat character
  --             :with_move(cond.none())
  --         -- don't delete if the next character is xx
  --             :with_del(cond.not_after_regex "xx")
  --         -- disable adding a newline when you press <cr>
  --             :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },

  -- disable auto maps set by Astronvim
  -- {
  --   "numToStr/Comment.nvim",
  --   opts = { keys = {}, mappings = { basic = false, extra = false } },
  -- },

  {
    "moll/vim-bbye", -- :Bd
    lazy = false,
    setup = function()
      -- always use buffer delete map
      vim.cmd [[cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR>]]
    end,
  },

  {
    -- Open some/file:line:column
    "wsdjeg/vim-fetch",
    lazy = false,
  },

  -- -- UI
  -- { -- visualize lsp-progress and other notifications
  --   "j-hui/fidget.nvim",
  --   tag = "legacy",
  --   event = "LspAttach",
  --   config = function() require("fidget").setup {} end,
  -- },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    opts = {},
    lazy = true,
  },

  {
    "P4Cu/ctrlsf-ui.nvim",
    -- name = "P4Cu/ctrlsf-ui.nvim",
    -- dir = "~/repo/ctrlsf-ui.nvim/",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "dyng/ctrlsf.vim",
        cmd = {
          "CtrlSF",
          "CtrlSFClearHL",
          "CtrlSFClose",
          "CtrlSFFocus",
          "CtrlSFOpen",
          "CtrlSFQuickfix",
          "CtrlSFStop",
          "CtrlSFToggle",
          "CtrlSFUpdate",
        },
      },
    },
  },

  -- { "akinsho/toggleterm.nvim", opts = { shade_terminals = false } },
}
