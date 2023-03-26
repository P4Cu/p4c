
-- Inspecting lua can be done via:
-- lua = require('rust-tools')
--
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
--
-- https://github.com/t-troebst/config.nvim
--
-- https://github.com/nvm-sh/nvm - node version manager
--  nvm install stable && nvm use stable
--  npm install tree-sitter
--
-- TODO: info how to provide default on_attach!
--   https://www.reddit.com/r/neovim/comments/wdiv4p/setting_up_neovim_with_lsp_and_clangd/

local function check_nvim_version()
  local version = vim.version()
  if version.minor < 8 or version.patch < 3 then vim.cmd [[ echom "Use at least nvim 8.3" ]] end
end
check_nvim_version()


vim.g.mapleader = " "

-- " netrw is just annoyance - disable it by saying it's already loaded
-- " let loaded_netrwPlugin = 1

require 'config.packer'
require 'config.lsp'
require 'config.options'
require 'config.mappings'
require 'config.diagnostics'

require 'config.plugin.which-key'
require 'config.plugin.nvim-cmp'


vim.cmd [[ source ~/.config/nvim/vimrc ]]
vim.cmd [[cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR>]] -- always use buffer delete map

-- auto reload configs
local packerSyncGrp = vim.api.nvim_create_augroup("PackerSyncGrp", {})
vim.api.nvim_clear_autocmds({ group = packerSyncGrp })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = packerSyncGrp,
  -- TODO: path should be from data folder, it's used a few times in script already
  pattern = { "**/nvim/lua/config/*.lua", "**/nvim/plugin/*main.lua" },
  command = "source <afile> | PackerCompile",
})
