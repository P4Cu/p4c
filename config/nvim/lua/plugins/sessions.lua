return {
    'Shatur/neovim-session-manager',
    config = function()
        require 'session_manager'.setup {
            autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
            autosave_only_in_session = true,
        }
        -- no space after command is important as otherwise it fails
        vim.cmd [[command! Session SessionManager load_session]]
        vim.cmd [[command! SessionDelete SessionManager delete_session]]
        vim.cmd [[command! SessionSaveCurrent SessionManager save_current_session]]
    end
}
