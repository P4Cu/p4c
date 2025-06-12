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
