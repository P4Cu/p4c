vim.api.nvim_create_autocmd("Filetype", {
  pattern = "rust",
  callback = function()
    local rt = require "rust-tools"
    local opts = { buffer = 0, prefix = "<LocalLeader>", mode = "n" }
    local nmap = {
      a = { rt.hover_actions.hover_actions, "[RUST] Hover actions" },
      T = { rt.open_cargo_toml.open_cargo_toml, "[Rust] Open toml" },
      r = { rt.runnables.runnables, "[Rust] runnables" },
      d = { rt.debuggables.debuggables, "[Rust] debuggables" },
      P = { rt.parent_module.parent_module, "[Rust] parent module" },
    }
    require("which-key").register(nmap, opts)
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "cpp",
  callback = function()
    local opts = { buffer = 0, prefix = "<LocalLeader>", mode = "n" }
    local nmap = {
      G = { "<CMD>ClangdSwitchSourceHeader<CR>", "Switch Source Header" },
      c = {
        name = "CMake",
        d = { "<CMD>CMakeDebug<CR>", "debug" },
        r = { "<CMD>CMakeRun<CR>", "run" },
        b = { "<CMD>CMakeBuild<CR>", "build" },
        C = { "<CMD>CMakeClean<CR>", "clean" },
        s = { "<CMD>CMakeSettings<CR>", "settings" },
        S = { "<CMD>CMakeTargetSettings<CR>", "settings (target)" },
        -- CMakeSelectBuildTarget CMakeSelectLaunchTarget
        -- CMakeRunTest
        -- CMakeOpenExecutor CMakeCloseExecutor CMakeOpenRunner CMakeCloseRunner CMakeStopRunner CMakeStopExecutor
        -- CMakeShowTargetFiles

        -- CMakeQuickRun               CMakeSelectBuildPreset      CMakeSelectCwd
        -- CMakeGenerate               CMakeRun                    CMakeSelectKit
        -- CMakeInstall                CMakeQuickBuild             CMakeSelectBuildType
        -- CMakeLaunchArgs             CMakeQuickDebug             CMakeSelectBuildDir         CMakeSelectConfigurePreset
      },
    }
    require("which-key").register(nmap, opts)

    -- TODO: https://github.com/p00f/clangd_extensions.nvim#inlay-hints
    -- TODO: https://github.com/p00f/clangd_extensions.nvim#view-ast
    -- TODO: https://github.com/p00f/clangd_extensions.nvim#completion-scores
    -- TODO: https://github.com/p00f/clangd_extensions.nvim#symbol-info
    -- TODO: https://github.com/p00f/clangd_extensions.nvim#type-hierarchy
    -- TODO: https://github.com/p00f/clangd_extensions.nvim#memory-usage
  end,
})

-- vim.api.nvim_create_augroup("DiagnosticMode", { clear = true })
-- vim.api.nvim_create_autocmd("ModeChanged", {
--   desc = "Show diagnostics in normal mode",
--   pattern = "*:n",
--   group = "DiagnosticMode",
--   callback = function(_) vim.diagnostic.show() end,
-- })
-- vim.api.nvim_create_autocmd("ModeChanged", {
--   desc = "Hide diagnostics in non-normal mode",
--   pattern = "n:*",
--   group = "DiagnosticMode",
--   callback = function(_) vim.diagnostic.hide() end,
-- })
