-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- vim.pretty_print { opts }
    local opts2 = vim.tbl_deep_extend("force", opts, {
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      highlight = {
        enable = true,
      },
      incremental_selection = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = false,
        },
      },
    })
    -- override
    opts2.textobjects.select.keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = { query = "@function.outer", desc = "around function" },
      ["if"] = { query = "@function.inner", desc = "inside function" },
      ["ac"] = { query = "@class.outer", desc = "around class" },
      ["ic"] = { query = "@class.inner", desc = "inside class" },
      ["ab"] = { query = "@block.outer", desc = "around block" },
      ["ib"] = { query = "@block.inner", desc = "inside block" },
      ["ip"] = { query = "@parameter.inner", desc = "inside parameter" },
      ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
    }
    return opts2
  end,
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    if vim.fn.has "win32" == 1 then require("nvim-treesitter.install").compilers = { "zig", "clang", "gcc" } end

    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup(opts)
  end,
  dependencies = {
    { "HiPhish/rainbow-delimiters.nvim" },
    {
      "nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
    },
  },
}
