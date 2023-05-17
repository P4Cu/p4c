return function()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "cpp", "python" },
    highlight = {
      enable = true,
    },
    incremental_selection = { enable = true },
    textobjects = {
      select = {
        enable = true,
        -- lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = { query = "@function.outer", desc = "around function" },
          ["if"] = { query = "@function.inner", desc = "inside function" },
          ["ac"] = { query = "@class.outer", desc = "around class" },
          ["ic"] = { query = "@class.inner", desc = "inside class" },
          ["ab"] = { query = "@block.outer", desc = "around block" },
          ["ib"] = { query = "@block.inner", desc = "inside block" },
          ["ip"] = { query = "@parameter.inner", desc = "inside parameter" },
          ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
        },
      },
    },
    rainbow = {
      enable = true,
      disable = {},
      query = 'rainbow-parens',
      -- Highlight the entire buffer all at once
      strategy = require 'ts-rainbow'.strategy.global,
    }
  }
end
