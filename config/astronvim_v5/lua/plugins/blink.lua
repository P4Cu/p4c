return {
  "Saghen/blink.cmp",
  opts = {
    cmdline = {
      -- Disable as blink completition for cmdline is not yet superior to nvims
      enabled = false,

      completion = {
        list = {
          selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = false,
            -- When `true`, inserts the completion item automatically when selecting it
            auto_insert = false,
          },
        },
        -- Whether to automatically show the window when new completion items are available
        menu = { auto_show = false },
        -- Displays a preview of the selected item on the current line
        ghost_text = { enabled = true },
      },
    },
  },
}
