return function()
  require 'lualine'.setup {
    options = {
      theme = 'auto',
      globalstatus = true, -- https://github.com/neovim/neovim/pull/17266
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',     -- TODO: on_click gitui
        'diff',       -- TODO: on_click gitui
        'diagnostics' -- TODO: telescope diagnostics (buffnr=0 <- current)
      },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },

    tabline = {
      lualine_a = { { 'tabs', mode = 2, max_length = function() return vim.o.columns * 1.0 end } },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },

    winbar = {
      lualine_a = { 'searchcount' },
      lualine_b = {
        {
          'filename',
          on_click = function() require 'telescope.builtin'.buffers() end,
        }
      },
      lualine_c = {},
      lualine_x = {
        {
          function() return require("nvim-navic").get_location() end,
          cond = function() return require("nvim-navic").is_available() end
          -- TODO: on_click should go to some searching
        },
      },
      lualine_y = {},
      lualine_z = {}
    },

    -- inactive split
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },

  }
end
