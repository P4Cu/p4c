vim.g.mapleader = " "

-- " netrw is just annoyance - disable it by saying it's already loaded
-- " let loaded_netrwPlugin = 1

vim.g.ale_completion_enabled = 1
vim.g.ale_linters = {
  python = {'pylsp', 'flake8', 'mypy', 'pylint', 'pyright'},
  rust = {'analyzer'},
}

require ('config.packer')
require ('config.options')
require ('config.mappings')

vim.cmd('source ~/.config/nvim/vimrc')

