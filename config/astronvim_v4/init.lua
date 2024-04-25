-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution

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

-- TODO: better https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/health.lua
local function check_nvim_version()
  local version = vim.version()
  if version.minor < 9 then vim.cmd [[ echom "Use at least nvim 8.3" ]] end
end
check_nvim_version()

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
  { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
