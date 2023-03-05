
-- Inspecting lua can be done via:
-- lua = require('rust-tools')
--
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
--
-- https://github.com/t-troebst/config.nvim


vim.g.mapleader = " "

-- " netrw is just annoyance - disable it by saying it's already loaded
-- " let loaded_netrwPlugin = 1

vim.g.ale_linters = {
  python = {'pylsp', 'flake8', 'mypy', 'pylint', 'pyright'},
  rust = {'analyzer'},
}

require 'config.packer'
require 'config.options'
require 'config.mappings'
require 'config.diagnostics'
require 'config.lsp'

require 'config.plugin.telescope'
require 'config.plugin.airline'
require 'config.plugin.startify'
require 'config.plugin.which-key'
require 'config.plugin.nvim-cmp'

vim.cmd([[ colorscheme gruvbox8 ]])

vim.cmd('source ~/.config/nvim/vimrc')
vim.cmd([[ cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR> ]]) -- always use buffer delete map

