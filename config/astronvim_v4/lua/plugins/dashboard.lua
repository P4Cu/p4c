return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local button = opts.button
      opts.section.buttons.val = {
        button("LDR S .", "⚑  Current directory session  "),
        button("LDR S l", "  Last Session               "),
        button("LDR S f", "  Find Session               "),
        button("LDR n", "  New File                     "),
        button("LDR f f", "  Find File                  "),
        button("LDR f o", "󰈙  Recents                    "),
        button("LDR f w", "󰈭  Find Word                  "),
        button("LDR f '", "  Bookmarks                  "),
      }
      opts.section.header.val = {}
      opts.config.layout[1].val = 0 -- vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }
      opts.config.layout[3].val = 7
      return opts
    end,
  },
}
