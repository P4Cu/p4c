-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.fn.matchadd("EolSpaces", "/\\s\\+$/")
vim.api.nvim_set_hl(0, "EolSpaces", { bg = "red" })

vim.cmd [[ "
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/
" ]]

-- vim.cmd [[ source ~/.config/nvim/vimrc ]]

-- -- -- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

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
