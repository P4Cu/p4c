-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = { severity = { min = vim.diagnostic.severity.ERROR } },
      -- signs = true, # TODO: fails as it expects table
      severity_sort = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        listchars = "trail:·,tab:»· ,nbsp:+",
        clipboard = "unnamedplus",

        wrapscan = false, -- do not wrap search
        wildmode = "longest,list,full",
        scrolloff = 10, -- always show x lines
        swapfile = false,
        colorcolumn = { 101 },
        completeopt = "menu,menuone,preview,noselect,noinsert",
        cmdheight = 1, -- Setting it to 0 has still too many annoyances
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      -- second key is the lefthand side of the map
      -- tables with just a `desc` key will be registered with which-key if it's installed
      -- this is useful for naming menus
      n = {
        ["<Leader>,"] = { remap = true, desc = "Like <LocalLeader>" },

        ["<Leader>b"] = { desc = "Buffers" },

        ["<Leader>e"] = { "<cmd>Neotree toggle current reveal_force_cwd<cr>", desc = "Toggle Explorer" },
        ["\\"] = { "<cmd>Neotree toggle current reveal_force_cwd<cr>", desc = "Toggle Explorer", noremap = false },

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
        ["<Leader><Leader>a"] = { function() require("harpoon"):list():add() end, desc = "Harpoon add" },
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
        ["<Leader>t"] = { desc = require("astroui").get_icon("Tab", 1, true) .. "Tab" },
        ["<Leader>tn"] = { "<cmd>tab split<CR>", desc = "tab new" },
        ["<Leader>tc"] = { "<cmd>tabclose<CR>", desc = "tab close" },
        ["<Leader>to"] = { "<cmd>tabonly<CR>", desc = "tab only" },
        ["<Leader>tm"] = { desc = require("astroui").get_icon("Tab", 1, true) .. "Move" },
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
    },
  },
}
