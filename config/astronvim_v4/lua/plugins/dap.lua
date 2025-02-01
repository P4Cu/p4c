return {
  {
    "mfussenegger/nvim-dap",

    config = function()
      -- require "plugins.configs.nvim-dap"(plugin, opts) - not existing as of yet
      local dap = require "dap"

      -- TODO: this will not work when running in docker as then it won't be able to run

      -- dap.defaults.fallback.force_external_terminal = true
      -- dap.defaults.fallback.external_terminal = {
      --   command = "tmux",
      --   args = { "new-window", "-ad", "-c", "<desired-root-dir>" },
      -- }

      -- configure one-small-step-for-vimkind
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }
      dap.adapters.nlua = function(callback, config)
        -- To debug an nvim plugin:
        --   1) start `require"osv".launch({port = 8086})` in debugee
        --   2) Open another nvim, find source by `:command Telescope`
        --   3) set breakpoint and hit F5 (dap continue)
        callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
      end
      ------------------------------------------------------------
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 0.2,
        },
        {
          elements = {
            {
              id = "console",
              size = 1.0,
            },
          },
          position = "right",
          size = 0.5,
        },
        {
          elements = { {
            id = "repl",
            size = 1.0,
          } },
          position = "bottom",
          size = 5,
        },
      },
    },
  },

  {
    "jbyuki/one-small-step-for-vimkind",
    dependencies = { "mfussenegger/nvim-dap" },
  },
}
