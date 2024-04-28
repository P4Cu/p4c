local utils = require "astrocore"
local extend_tbl = utils.extend_tbl

-- https://github.com/Civitasv/cmake-tools.nvim/blob/master/docs/howto.md#mimic-ui-of-cmake-tools-toolbar-in-visual-studio-code
-- https://docs.astronvim.com/recipes/status/

-- TODO: when build running show stop executor, when debugging/running stop runner

local function cmake(opts)
  local init = require "astroui.status.init"
  local status = require "astroui.status"
  local status_utils = require "astroui.status.utils"
  local builder = require("astroui.status.component").builder

  local function is_cmake_tools()
    if package.loaded["cmake-tools"] then
      return require("cmake-tools").is_cmake_project()
    else
      return false
    end
  end

  status.provider.cmake_build_dir = function(opts)
    return function()
      local cmake = require "cmake-tools"
      local build_dir = cmake.get_build_directory()
      local text = build_dir and build_dir:normalize() or "<not_set>"
      text = "[" .. text .. "]"
      return status.utils.stylize(text, opts)
    end
  end

  status.provider.cmake_build_target = function(opts)
    return function(_)
      local cmake = require "cmake-tools"
      local text = cmake.get_build_target() or "<select>"
      text = "[" .. text .. "]"
      return status.utils.stylize(text, opts)
    end
  end

  status.provider.cmake_build_type = function(opts)
    return function(_)
      local cmake = require "cmake-tools"
      local text = cmake.get_build_type() or "<select>"
      text = "[" .. text .. "]"
      return status.utils.stylize(text, opts)
    end
  end

  status.provider.cmake_launch_target = function(opts)
    return function(_)
      local cmake = require "cmake-tools"
      local text = cmake.get_launch_target() or "<select>"
      text = "[" .. text .. "]"
      return status.utils.stylize(text, opts)
      -- cmake.get_kit() -- return current using kit
      -- cmake.has_cmake_preset() -- return if there exists cmake presets configuration
      -- cmake.get_configure_preset() -- return current using configure preset
      -- cmake.get_build_preset() -- return current using build preset
    end
  end

  status.provider.cmake_run = function(opts)
    return function() return status.utils.stylize(" ", opts) end
  end
  status.provider.cmake_debug = function(opts)
    return function() return status.utils.stylize(" ", opts) end
  end
  status.provider.cmake_target_settings = function(opts)
    return function() return status.utils.stylize(" ", opts) end
  end

  opts = extend_tbl({
    cmake_build_dir = {
      icon = { kind = "Pencil", padding = { right = 1 } },
      on_click = {
        callback = function() vim.cmd "CMakeSettings" end,
        name = "heirline_cmake_settings",
      },
    },
    cmake_build_type = {
      padding = { left = 1 },
      icon = { kind = "Gear", padding = { right = 1 } },
      on_click = {
        callback = function() vim.cmd "CMakeSelectBuildType" end,
        name = "heirline_cmake_build_type",
      },
    },
    cmake_build_target = {
      padding = { left = 1 },
      icon = { kind = "Find", padding = { right = 1 } },
      on_click = {
        callback = function() vim.cmd "CMakeSelectBuildTarget" end,
        name = "heirline_cmake_build_target",
      },
    },
    cmake_run = {
      padding = { left = 1 },
      icon = { kind = "Run", padding = { right = 0 } },
      on_click = {
        callback = function() vim.cmd "CMakeRun" end,
        name = "heirline_cmake_run",
      },
    },
    cmake_debug = {
      padding = { left = 1 },
      icon = { kind = "Debug", padding = { right = 0 } },
      on_click = {
        callback = function() vim.cmd "CMakeDebug" end,
        name = "heirline_cmake_debug",
      },
    },
    cmake_target_settings = {
      padding = { left = 1 },
      icon = { kind = "Gear", padding = { right = 0 } },
      on_click = {
        callback = function() vim.cmd "CMakeTargetSettings" end,
        name = "heirline_cmake_target_settings",
      },
    },
    cmake_launch_target = {
      padding = { left = 1 },
      on_click = {
        callback = function() vim.cmd "CMakeSelectLaunchTarget" end,
        name = "heirline_cmake_launch_target",
      },
    },
    surround = { separator = "left", color = "git_branch_bg", condition = is_cmake_tools },
    -- hl = hl.get_attributes "git_branch",
    update = { "BufEnter", "DirChanged" },
    init = init.update_events { "BufEnter" },
  }, opts)
  return builder(status_utils.setup_providers(opts, {
    "cmake_build_dir",
    "cmake_build_type",
    "cmake_build_target",
    "cmake_run",
    "cmake_debug",
    "cmake_target_settings",
    "cmake_launch_target",
  }))
end

return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.file_info(),
      status.component.git_diff(),
      cmake(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
      -- status.component.mode({ surround = { separator = "right" } }),
    }

    return opts
  end,
}
