return {
    -- TODO: make lazy
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",        -- ui components
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
