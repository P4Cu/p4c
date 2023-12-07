return function()
    local actions = require "telescope.actions"
    require 'telescope'.setup {
        pickers = {
            buffers = {
                mappings = {
                    i = {
                        ["<c-d>"] = actions.delete_buffer,
                    }
                }
            },
        },
        extensions = {
            sessions_picker = {
                sessions_dir = vim.fn.stdpath('data') .. '/sessions/', -- same as '/home/user/.local/share/nvim/session'
            }
        },
    }
    require('telescope').load_extension('sessions_picker')
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("live_grep_args")
end
