-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",

  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },

  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.cpp" },

  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.git.diffview-nvim" },

  { import = "astrocommunity.debugging.telescope-dap-nvim" },
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },

  { import = "astrocommunity.code-runner.overseer-nvim" },
  -- { import = "astrocommunity.bars-and-lines.vim-illuminate" }, -- TODO: this was enabled, is it needed?
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- TODO: astrocommunity.diagnostics.trouble-nvim consider the dependency edgy-windows which looks promising

  -- TODO: neotest, though astrocommunity.test.neotest seems bad for my usecase, maybe on my own?
}
