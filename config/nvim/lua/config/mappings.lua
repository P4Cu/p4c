local opts = { noremap = true, silent = true }

-- " to have nice command search
vim.keymap.set('c', '<c-p>', '<up>')
vim.keymap.set('c', '<c-n>', '<down>')
vim.keymap.set('n', 'gb',    '<cmd>bnext<CR>')
vim.keymap.set('n', 'gB',    '<cmd>bprevious<CR>')
vim.keymap.set('',  '<C-_>', '<cmd>Commentary<CR>')
vim.keymap.set('',  '<F1>',  '<cmd>Clap<CR>')
vim.keymap.set('',  '<F3>',  '<cmd>Clap buffers<CR>')
vim.keymap.set('',  '<F4>',  '<cmd>A<CR>')
vim.keymap.set('n', '<F8>',  '<cmd>TagbarToggle<CR>')

vim.keymap.set('n',  '[g',  '<cmd>echo "use [c"<CR>')
vim.keymap.set('n',  ']g',  '<cmd>echo "use ]c"<CR>')
vim.keymap.set('n',  'cog', '<cmd>GitGutterLineHighlightsToggle<CR>')
-- vim.keymap.set('n',  [g <cmd>GitGutterPrevHunk<CR>
-- vim.keymap.set('n',  ]g <cmd>GitGutterNextHunk<CR>


vim.keymap.set('n', '<leader>1', '<Plug>AirlineSelectTab1')
vim.keymap.set('n', '<leader>2', '<Plug>AirlineSelectTab2')
vim.keymap.set('n', '<leader>3', '<Plug>AirlineSelectTab3')
vim.keymap.set('n', '<leader>4', '<Plug>AirlineSelectTab4')
vim.keymap.set('n', '<leader>5', '<Plug>AirlineSelectTab5')
vim.keymap.set('n', '<leader>6', '<Plug>AirlineSelectTab6')
vim.keymap.set('n', '<leader>7', '<Plug>AirlineSelectTab7')
vim.keymap.set('n', '<leader>8', '<Plug>AirlineSelectTab8')
vim.keymap.set('n', '<leader>9', '<Plug>AirlineSelectTab9')
vim.keymap.set('n', '<leader>[', '<Plug>AirlineSelectPrevTab')
vim.keymap.set('n', '<leader>]', '<Plug>AirlineSelectNextTab')



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

vim.keymap.set('n', '<C-p>',      '<cmd>echo "use \\<leader\\>ff"<CR>')
vim.keymap.set('n', '<leader>ff', '<cmd>Clap files<CR>')
vim.keymap.set('n', '<leader>fb', '<cmd>Clap buffers<CR>')
vim.keymap.set('n', '<leader>fm', '<cmd>Clap recent_files <CR>')
vim.keymap.set('n', '<F2>',       '<cmd>Clap tags<CR>')
vim.keymap.set('n', '<leader>f/', '<cmd>Clap blines<CR>')
vim.keymap.set('n', '<leader>f?', '<cmd>Clap lines<CR>')
vim.keymap.set('n', '<leader>fc', '<cmd>Clap command<CR>')

-- vim.keymap.set('n',  <leader>fc <cmd>Bdelete<CR>
vim.keymap.set('n', '<leader>hve', '<cmd>edit $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>hvr', '<cmd>source $MYVIMRC<CR>')

vim.keymap.set('i',  '<C-Space>',      '<Plug>(ale_complete)')
vim.keymap.set('n',  '<F20>', '<Plug>(ale_previous)')
vim.keymap.set('n',  '<F8>',  '<Plug>(ale_next)')
