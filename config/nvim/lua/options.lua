-- vim.opt.option = x
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- required for smartcase override with \C magic
vim.opt.smartcase = true
vim.opt.cursorline = true
-- " bashlike vim completition + with addition of third tab for list select mode (zsh alike )
vim.opt.wildmode = 'longest,list,full'
vim.opt.wildmenu = true
vim.opt.mouse = 'a'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10  -- always show x lines from cursor
vim.opt.undofile = true -- keep history for each file (allows undo after close) file.un~
vim.opt.gdefault = true -- rly mate, when i wanted to replace only the first occurence in line?
vim.opt.lazyredraw = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = 'trail:·,tab:»· ,nbsp:+' -- Whitespace
vim.opt.numberwidth = 5                     --  Numbering of lines
vim.opt.relativenumber = false
vim.opt.number = true                       -- use <cor> <con> to enable dispalying
vim.opt.wrap = false                        -- use <cow>
vim.opt.updatetime = 1000
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
-- "     vim.opt.inccommand=nosplit " looks like this is causing a redraw issues
vim.opt.wrapscan = false -- do not wrap the search!
-- if has("patch-8.1.0360")
vim.opt.diffopt = 'filler,closeoff,internal,algorithm:patience'
-- endif
vim.opt.clipboard = 'unnamedplus'
-- " This will automatically read changed file. It will ask if we have unsaved changes.
vim.opt.autoread = true
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal" -- what to save in sessions
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.colorcolumn = '101'
vim.opt.completeopt = 'menu,menuone,preview,noselect,noinsert'
vim.opt.shortmess = vim.opt.shortmess + "c" -- Avoid showing extra messages when using completion
-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.opt.signcolumn = "auto:1-2" -- one or two columns for diagnostic signs
-- best way for having folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99
