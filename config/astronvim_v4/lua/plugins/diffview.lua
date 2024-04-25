return {
  "sindrets/diffview.nvim",
  config = function()
    vim.cmd [[command! -nargs=* Dfo DiffviewOpen]]
    local actions = require "diffview.actions"
    require("diffview").setup {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
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
        },
      },
    }
  end,
}
