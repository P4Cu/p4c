local M = {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "williamboman/mason.nvim"
    },
}

-- small function to get dap.adapters.lldb
local function get_lldb_adapter()
    require 'mason'.setup() -- TODO: why is this needed!? WHY o lazy nvim !?!
    local mason_registry = require("mason-registry")
    local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
    local codelldb_path = codelldb_root .. "adapter/codelldb"
    local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
    return require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
end

-- configuration loaded on dap setup
M.ui_filetypes = { 'dapui_scopes', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches', 'dap-repl', 'dapui_console' }

-- all dap.ui windows filetypes - source code window is not included
function M.config()
    local dap, dapui = require("dap"), require("dapui")

    vim.api.nvim_create_user_command(
        'DapUiClose',
        function(_)
            require('dap').terminate()
            require('dapui').close()
            -- TODO: call
            -- require('config.mappings').dapui_terminate()
        end,
        { nargs = 0 }
    )

    -- first map available debugging adapters which later are mapped to filetypes
    dap.adapters.lldb = get_lldb_adapter()
    dap.adapters.rt_lldb = dap.adapters.lldb -- alternative name required by rust-tools
    dap.adapters.rust = dap.adapters.lldb

    -- set better json parser and load .vscode/launch.js
    require("dap.ext.vscode").json_decode = require("overseer.json").decode
    require("dap.ext.vscode").load_launchjs(
        nil, -- default .vscode/launch.json
        -- map configurations 'lldb' from launch.json to filetype
        { lldb = { 'c', 'cpp', 'rust' } }
    )
    -- And set always stopOnEntry for everything loaded from launch.json
    -- for _, lang_config in pairs(dap.configurations) do
    --     for _, config in pairs(lang_config) do
    --         config.stopOnEntry = true
    --     end
    -- end

    -- always open in next tmux pane and don't focus
    dap.defaults.fallback.force_external_terminal = true
    dap.defaults.fallback.external_terminal = {
        command = "tmux",
        args = { "new-window", "-ad", "-c", "<desired-root-dir>" },
    }

    -- setup gui looks
    dapui.setup {
        layouts = { {
            elements = { {
                id = "scopes",
                size = 0.25
            }, {
                id = "breakpoints",
                size = 0.25
            }, {
                id = "stacks",
                size = 0.25
            }, {
                id = "watches",
                size = 0.25
            } },
            position = "left",
            size = 40
        }, {
            elements = { {
                id = "repl",
                size = 1.0
            } },
            position = "bottom",
            size = 10
        } }
    }


    -- TODO: if we don't set a breakpoint and start a debug it will quit so fast that we don't close UI

    -- Open/Close UI on dap events
    dap.listeners.after.event_initialized["dapui_config"] = function()
        -- TODO: add key description
        -- use <F5> <F10> <F11> <F23>
        -- where <F5> could be remaped to local leader
        -- also most of these could be buffer local bindings for specific windows
        -- nevertheless they should be done from mappings.lua
        dapui.open()
        vim.keymap.set('n', '<LocalLeader>dc', function() require('dap').continue() end)
        vim.keymap.set('n', '<LocalLeader>dso', function() require('dap').step_over() end)
        vim.keymap.set('n', '<LocalLeader>dsi', function() require('dap').step_into() end)
        vim.keymap.set('n', '<LocalLeader>dsO', function() require('dap').step_out() end)
        vim.keymap.set('n', '<LocalLeader>db', function() require('dap').toggle_breakpoint() end)
        vim.keymap.set('n', '<LocalLeader>dB', function() require('dap').set_breakpoint() end)
        vim.keymap.set('n', '<LocalLeader>dBB',
            function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<LocalLeader>dr', function() require('dap').repl.open() end)
        vim.keymap.set('n', '<LocalLeader>dl', function() require('dap').run_last() end)
        vim.keymap.set({ 'n', 'v' }, '<LocalLeader>dh', function()
            require('dap.ui.widgets').hover()
        end)
        vim.keymap.set({ 'n', 'v' }, '<LocalLeader>dp', function()
            require('dap.ui.widgets').preview()
        end)
        vim.keymap.set('n', '<LocalLeader>df', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.frames)
        end)
        vim.keymap.set('n', '<LocalLeader>ds', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.scopes)
        end)
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

return M
