-- NOTE: don't use uppercase <Leader> as it does not play well with astronvim
return {
  -- first key is the mode
  n = {
    ["<Leader>e"] = { "<cmd>Neotree toggle current reveal_force_cwd<cr>", desc = "Toggle Explorer" },
    ["\\"] = { "<cmd>Neotree toggle current reveal_force_cwd<cr>", desc = "Toggle Explorer", noremap = false },

    -- mappings seen under group name "Buffer"
    ["<Leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<Leader>b"] = { name = "Buffers" },

    ["<BS>"] = { '"_X', desc = "Black hole delete" },
    ["<Del>"] = { '"_x', desc = "Black hole delete" },

    gb = { function() vim.notify("Use ]b", vim.log.levels.WARN) end, desc = "which_key_ignore" },
    gB = { function() vim.notify("Use [b", vim.log.levels.WARN) end, desc = "which_key_ignore" },

    cp = { '<cmd>let @+ = expand("%:p")<cr><bar>:echo "Copied full file path"<cr>', desc = "Copy full file path" },
    cP = {
      '<cmd>let @+ = expand("%:p") . ":" . line(".")<cr><bar>:echo "Copied full file path with line number"<cr>',
      desc = "Copy file path and line",
    },

    -- TODO: these could be set by autocommands with name maching file
    ["<Leader><Leader>a"] = { function() require("harpoon"):list():append() end, desc = "Harpoon add" },
    ["<Leader><Leader>e"] = {
      function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
      desc = "Harpoon menu",
    },
    -- ["<Leader><Leader>n"] = { function() require("harpoon"):list():next() end, desc = "Harpoon next" },
    -- ["<Leader><Leader>p"] = { function() require("harpoon"):list():prev() end, desc = "Harpoon prev" },
    ["<Leader><Leader>1"] = { function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
    ["<Leader><Leader>2"] = { function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
    ["<Leader><Leader>3"] = { function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
    ["<Leader><Leader>4"] = { function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },

    ["<C-_>"] = { require("Comment.api").toggle.linewise.current, desc = "Toggle comment line" },
    ["[h"] = { function() require("gitsigns").next_hunk() end, desc = "Previous Git hunk", noremap = false },
    ["]h"] = { function() require("gitsigns").prev_hunk() end, desc = "Next Git hunk", noremap = false },

    ["<F1>"] = { "<cmd>Telescope builtin include_extensions=true<CR>", desc = "Telescope" },
    ["<F13>"] = { "<cmd>Telescope resume<CR>", desc = "Telescope resume" },

    ["<Leader>fg"] = {
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      desc = "ripgrep",
    },

    -- tabs manipulation
    ["<Leader>t"] = { desc = require("astronvim.utils").get_icon("Tab", 1, true) .. "Tab" },
    ["<Leader>tn"] = { "<cmd>tab split<CR>", desc = "tab new" },
    ["<Leader>tc"] = { "<cmd>tabclose<CR>", desc = "tab close" },
    ["<Leader>to"] = { "<cmd>tabonly<CR>", desc = "tab only" },
    ["<Leader>tm"] = { desc = require("astronvim.utils").get_icon("Tab", 1, true) .. "Move" },
    ["<Leader>tmp"] = { "<cmd>-tabmove<CR>", desc = "move tab backwards" },
    ["<Leader>tmn"] = { "<cmd>+tabmove<CR>", desc = "move tab forward" },
    -- unmap toggleterm <Leader>t
    -- THIS unmapping does not work well
    ["<Leader>tl"] = false,
    ["<Leader>tu"] = false,
    ["<Leader>tt"] = false,
    ["<Leader>tp"] = false,
    ["<Leader>tf"] = false,
    ["<Leader>th"] = false,
    ["<Leader>tv"] = false,

    ["<LocalLeader>o"] = { name = "Overseer" },
    ["<LocalLeader>oo"] = { "<cmd>OverseerToggle<CR>", desc = "Overseer toggle" },
    ["<LocalLeader>ol"] = { "<cmd>OverseerLoadBundle<CR>", desc = "Overseer load" },
    ["<LocalLeader>of"] = { "<cmd>OverseerQuickAction open float<CR>", desc = "Overseer float" },
    ["<LocalLeader>oI"] = { "<cmd>OverseerInfo<CR>", desc = "Overseer info" },
    ["<LocalLeader>oS"] = { "<cmd>OverseerSaveBundle<CR>", desc = "Overseer save bundle" },
    ["<LocalLeader>oT"] = { "<cmd>OverseerTaskAction<CR>", desc = "Overseer task action" },

    -- ["<Leader>sf"] = { "<Plug>CtrlSFPrompt", desc = "CtrlSF", noremap = false },
    ["<Leader>sf"] = { function() require("ctrlsf-ui").show() end, desc = "CtrlSF" },

    ["<Leader>df"] = {
      function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").threads) end,
      desc = "Frames",
    },
    ["<Leader>dS"] = {
      function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end,
      desc = "Scopes",
    },
    ["<Leader>dL"] = {
      function() require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ") end,
      desc = "Logpoint",
    },
    ["<Leader>dO"] = false, -- Step Out (S-F11)
    ["<Leader>do"] = false, -- Step Over (F10)
    -- TODO: make dR as dr and dr as dR
    ["<Leader>dr"] = { function() require("dap").run_last() end, desc = "Run last" }, -- Restart (C-F5)
    ["<Leader>dc"] = false, -- Start/Continue (F5)
    ["<Leader>di"] = false, -- Step Into (F11)
    ["<Leader>dp"] = false, -- Pause (F6)
    -- TODO: turn above info into help <Leader>dH or as <Leader>dd<key>
    -- h  Debugger Hover -- TODO: maybe debugger hover on cursor hold?

    ["<Leader>gr"] = { ":Gitsigns reset_hunk<CR>", desc = "Reset git hunk" },
    ["<Leader>gR"] = { ":Gitsigns reset_buffer<CR>", desc = "Reset git buffer" },
  },
  v = {
    ["<BS>"] = { '"_x', desc = "Black hole delete" },
    ["<Del>"] = { '"_x', desc = "Black hole delete" },
    ["<C-_>"] = { "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment selection" },

    ["<Leader>gr"] = { ":Gitsigns reset_hunk<CR>", desc = "Reset git hunk" },
    ["<Leader>gs"] = { ":Gitsigns stage_hunk<CR>", desc = "Stage git hunk" },

    ["<Leader>fg"] = {
      function() require("telescope-live-grep-args.shortcuts").grep_visual_selection() end,
      desc = "ripgrep",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  x = {
    il = { "g_o_", desc = "inside line" },
    al = { "$o0", desc = "around line" },
    ih = { ":<C-U>Gitsigns select_hunk<CR>", desc = "in git hunk" },
  },
  o = {
    il = { ":normal vil<CR>", desc = "inside line" },
    al = { ":normal val<CR>", desc = "around line" },
    ih = { ":<C-U>Gitsigns select_hunk<CR>", desc = "in git hunk" },
  },
  c = {
    -- command search completes currently entered text
    ["<c-p>"] = "<up>",
    ["<c-n>"] = "<down>",
  },
}
