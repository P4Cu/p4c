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

-- TODO: this file should be super simplified

local function check_nvim_version()
  local version = vim.version()
  if version.minor < 9 then vim.cmd [[ echom "Use at least nvim 8.3" ]] end
end
check_nvim_version()

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>,", ",", { remap = true, desc="Like <LocalLeader>" }) -- , is not typical maping, so we need to map it instead of unmap

-- TODO: either move them to respective groups in packer or load in order like 01-xxx / 02-xxx
require 'config.packer'
require 'config.lsp'
require 'config.options'
require 'config.mappings'
require 'config.diagnostics'

require 'config.plugin.nvim-cmp'


vim.cmd [[ source ~/.config/nvim/vimrc ]]
vim.cmd [[cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR>]] -- always use buffer delete map
