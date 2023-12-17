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

-- TODO: better https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/health.lua
local function check_nvim_version()
    local version = vim.version()
    if version.minor < 9 then vim.cmd [[ echom "Use at least nvim 8.3" ]] end
end
check_nvim_version()

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>,", ",", { remap = true, desc = "Like <LocalLeader>" }) -- , is not typical maping, so we need to map it instead of unmap

-- setup Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')

require('options')
require('mappings')

vim.diagnostic.config {
    virtual_text = false,
    -- signs = {
    -- active = signs,
    -- },
    signs = true,
    underline = { severity = { min = vim.diagnostic.severity.ERROR } },
    severity_sort = true,
    float = {
        -- style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.cmd [[ source ~/.config/nvim/vimrc ]]
vim.cmd [[cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR>]] -- always use buffer delete map
