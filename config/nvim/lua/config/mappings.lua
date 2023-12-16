-- delete to black hole
vim.keymap.set('n',  'X',  '"_x')
vim.keymap.set('v',  'X',  '"_x')

-- " to have nice command search
vim.keymap.set('c', '<c-p>', '<up>')
vim.keymap.set('c', '<c-n>', '<down>')
vim.keymap.set('n', 'gb',    '<cmd>bnext<CR>')
vim.keymap.set('n', 'gB',    '<cmd>bprevious<CR>')
vim.keymap.set('n',  '<C-_>', require('Comment.api').toggle.linewise.current)
vim.keymap.set('v',  '<C-_>', '<Plug>(comment_toggle_linewise_visual)')
vim.keymap.set('',  '<F1>',  '<cmd>Telescope builtin include_extensions=true<CR>')
vim.keymap.set('',  '<F13>', '<cmd>Telescope resume<CR>')
vim.keymap.set('',  '<F2>',  '<cmd>Telescope buffers<CR>')
vim.keymap.set('',  '<F14>',  '<cmd>Telescope oldfiles<CR>')
vim.keymap.set('',  '<F3>',  '<cmd>Telescope lsp_document_symbols<CR>')
vim.keymap.set('',  '<F15>', '<cmd>Telescope lsp_workspace_symbols<CR>')
vim.keymap.set('',  '<F7>',  '<cmd>OverseerToggle<CR>')
vim.keymap.set('',  '<F19>',  '<cmd>OverseerLoadBundle<CR>')
vim.keymap.set('', '<F31>', '<cmd>OverseerQuickAction open<CR>')

vim.keymap.set('n',  '[g',  '<cmd>echo "use [c"<CR>')
vim.keymap.set('n',  ']g',  '<cmd>echo "use ]c"<CR>')
vim.keymap.set('n',  'cog', '<cmd>GitGutterLineHighlightsToggle<CR>')


-- " CtrlSF
vim.keymap.set('n', '<leader>sf', '<Plug>CtrlSFPrompt')
vim.keymap.set('n', '<leader>ss', '<Plug>CtrlSFStop')
vim.keymap.set('v', '<leader>sf', '<Plug>CtrlSFVwordPath')
vim.keymap.set('v', '<leader>sF', '<Plug>CtrlSFVwordExec')
vim.keymap.set('n', '<leader>sn', '<Plug>CtrlSFCwordPath')
vim.keymap.set('n', '<leader>sp', '<Plug>CtrlSFPwordPath')
vim.keymap.set('n', '<leader>so', '<cmd>CtrlSFOpen<CR>')
vim.keymap.set('n', '<leader>st', '<cmd>CtrlSFToggle<CR>')
-- vim.keymap.set('i',  <leader>st <Esc>:CtrlSFToggle<CR>

-- " working with filepaths/numbers
vim.keymap.set('n', 'cp',  '<cmd>let @+ = expand("%:p")<cr><bar>:echo "Copied full file path"<cr>')
vim.keymap.set('n', 'cpl', '<cmd>let @+ = expand("%:p") . ":" . line(".")<cr><bar>:echo "Copied full file path with line number"<cr>')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- Do not jump on pressing star
-- vim.keymap.set('',  <silent> * <cmd>let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

vim.keymap.set('v', 'v',     '<Plug>(expand_region_expand)')
vim.keymap.set('v', '<C-v>', '<Plug>(expand_region_shrink)')

-- " missing toggle paste
vim.keymap.set('n', 'cop', '<cmd>setlocal <C-R>=<SNR>61_toggle("paste")<CR><CR>')

vim.g.Lf_ShortcutF = "<leader>ff"
vim.g.Lf_ShortcutF = ""
vim.g.Lf_ShortcutB = ""

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope fd<CR>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep_args<CR>')
-- vim.keymap.set('v', '<leader>fg', '<cmd>Telescope grep_string<CR>')
vim.keymap.set("v", "<leader>fg", require("telescope-live-grep-args.shortcuts").grep_visual_selection)
vim.keymap.set('n', '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope commands<CR>')
vim.keymap.set('n', '<leader>fm', '<cmd>Telescope keymaps<CR>')

-- vim.keymap.set('n',  <leader>fc <cmd>Bdelete<CR>
vim.keymap.set('n', '<leader>hve', '<cmd>edit $MYVIMRC<CR>')

-- tabs manipulation
vim.api.nvim_set_keymap("n", "<leader>tn",  "<cmd>tab split<CR>", { desc = 'tab new' })
vim.api.nvim_set_keymap("n", "<leader>tc",  "<cmd>tabclose<CR>",  { desc = 'tab close' })
vim.api.nvim_set_keymap("n", "<leader>to",  "<cmd>tabonly<CR>",   { desc = 'tab only' })
vim.api.nvim_set_keymap("n", "<leader>tmp", "<cmd>-tabmove<CR>",  { desc = 'move tab backwards' })
vim.api.nvim_set_keymap("n", "<leader>tmn", "<cmd>+tabmove<CR>",  { desc = 'move tab forward' })

vim.keymap.set('n', '\\', '<cmd>Neotree toggle current reveal_force_cwd<cr>', { desc = 'neotree toggle' })
