-- TODO: maybe use instead?: https://github.com/echasnovski/mini.nvim#ministarter there are other goodies there
-- https://www.reddit.com/r/neovim/comments/ug2v0n/finally_found_a_good_replacement_for_startify/

vim.g.startify_bookmarks = { '~/.zshrc' }
-- vim.cmd [[
-- g:startify_lists = [
--   \ { 'type': 'sessions',  'header': ['   Sessions']       },
--   \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
--   \ { 'type': 'files',     'header': ['   MRU']            },
--   \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
--   \ { 'type': 'commands',  'header': ['   Commands']       },
--   \ ]
-- ]]
vim.g.startify_session_persistence=1
