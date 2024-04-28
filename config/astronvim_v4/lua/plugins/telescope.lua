-- TODO: path_display now supports higlight groups as second params so no need to add autocommand
-- https://github.com/nvim-telescope/telescope.nvim/pull/3074
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t\t.*\t\t")
      vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
    end)
  end,
})

local function filenameFirst(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then return tail end
  -- TODO: improve so we don't need to search for \t\t
  return string.format("%s\t\t%s\t\t", tail, parent)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-live-grep-args.nvim" },
    opts = function(_, opts)
      local actions = require "telescope.actions"
      local actions_generate = require "telescope.actions.generate"
      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            height = 0.98,
            width = 0.98,
            preview_cutoff = 20, -- disable preview when height less than
          },
          results_title = "Results - [?] for help in normal-mode",
          mappings = {
            i = {
              ["<c-f>"] = actions.to_fuzzy_refine,
            },
            n = {
              ["?"] = actions_generate.which_key {
                only_show_current_mode = false,
                max_height = 0.8,
              },
            },
          },
          path_display = filenameFirst,
          -- path_display = { shorten = 5 },
          -- path_display = { "smart" },
        },
        pickers = {
          live_grep = {
            mappings = {
              i = {},
            },
          },
          buffers = {
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = {
              -- extend mappings
              i = {
                -- TODO: marked as anonymous
                ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt { postfix = " --iglob " },
              },
            },
          },
        },
      })
    end,
  },
}
