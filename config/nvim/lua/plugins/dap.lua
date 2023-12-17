-- small function to get dap.adapters.lldb
local function get_lldb_adapter()
    require 'mason'.setup() -- TODO: why is this needed!? WHY o lazy nvim !?!
    local mason_registry = require("mason-registry")
    local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
    local codelldb_path = codelldb_root .. "adapter/codelldb"
    local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
    return require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
end

local function map(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { desc = desc })
end

local function nmap(key, action, desc)
    map("n", key, action, desc)
end

local function nvmap(key, action, desc)
    map({ "n", "v" }, key, action, desc)
end

local function dap_config()
    local dap = require("dap")

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
end

function dapui_config()
    local dap, dapui = require("dap"), require("dapui")

    vim.api.nvim_create_user_command(
        'DapUiClose',
        function(_)
            dap.terminate()
            dapui.close()
            -- TODO: call
            -- require('config.mappings').dapui_terminate()
        end,
        { nargs = 0 }
    )

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

    local keymap = require('keymap').dapui

    -- keys to set always
    nmap(keymap.toggle_breakpoint, dap.toggle_breakpoint, 'Toggle breakpoint')
    nmap(keymap.set_logpoint,
        function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        'Set logpoint')
    nmap(keymap.set_conditional_breakpoint,
        function() dap.set_breakpoint(vim.fn.input('Condition: '), nil, nil) end,
        'Set conditional')
    nmap(keymap.run_last, dap.run_last, 'Run last')
    nmap(keymap.terminate, dap.terminate, 'Terminate')
    nmap(keymap.continue, dap.continue, 'Continue')

    local widgets = require('dap.ui.widgets')

    -- Open/Close UI on dap events
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
        nmap(keymap.step_over, dap.step_over, 'Step over')
        nmap(keymap.step_into, dap.step_into, 'Step into')
        nmap(keymap.step_out, dap.step_out, 'step out')
        nmap(keymap.repl, dap.repl.toggle, 'Repl toggle')
        nvmap(keymap.hover, widgets.hover, 'Hover')
        nvmap(keymap.preview, widgets.preview, 'Preview')
        nmap(keymap.frames_float, function() widgets.centered_float(widgets.frames) end, 'Frames float')
        nmap(keymap.scopes_float, function() widgets.centered_float(widgets.scopes) end, 'Scopes float')
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

return {
    {
        "mfussenegger/nvim-dap",
        config = dap_config,
    },
    {
        "rcarriga/nvim-dap-ui",
        config = dapui_config,
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim"
        },
    },

    -- all dap.ui windows filetypes - source code window is not included
    ui_filetypes = {
        'dapui_scopes', 'dapui_breakpoints', 'dapui_stacks',
        'dapui_watches', 'dap-repl', 'dapui_console'
    },
}
