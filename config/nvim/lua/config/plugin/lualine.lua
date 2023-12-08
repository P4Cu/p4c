return function()
  require 'lualine'.setup {
    options = {
      theme = 'auto',
      globalstatus = true, -- https://github.com/neovim/neovim/pull/17266
      disabled_filetypes = require('config.plugin.dap').ui_filetypes,
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
          { 'branch', on_click = function ()
              vim.cmd('Git branch --list')
          end },
          { 'diff', on_click = function ()
              if next(require('diffview.lib').views) == nil then
                vim.cmd('DiffviewOpen')
              else
                vim.cmd('DiffviewClose')
              end
          end },
          { 'diagnostics', always_visible = true,
            on_click = function(_ --[[ number_of_clicks ]], mouse_button, _ --[[ key_modifiers ]])
              if mouse_button == 'l' then
                  require('trouble').toggle()
              elseif mouse_button == 'r' then
                  vim.cmd('TodoTrouble')
            end
          end },
      },
      lualine_c = { 'filename' },
      lualine_x = { 'overseer', 'encoding', 'fileformat', 'filetype' },
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
          -- function() return vim.fn['nvim_treesitter#statusline(90)'] end,
          function()
            return require'nvim-treesitter'.statusline {
              type_patterns = {'namespace', 'class', 'function', 'method'},
              transform_fn = function(line, _ --[[ node ]])
                  line = line:gsub('%s*[%[%(%{]*%s*$', '')
                  line = line:gsub('namespace ', '')
                return line
              end,
            }
          end,
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
