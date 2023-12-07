return function()
    require('gitsigns').setup {
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = 'git next hunk' })

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = 'git prev hunk' })

            -- Actions
            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = 'git stage hunk' })
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = 'git reset hunk' })
            map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
            map('n', '<leader>hS', gs.stage_buffer, { desc = 'git stage buffer' })
            map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'git undo stage hunk' })
            map('n', '<leader>hR', gs.reset_buffer, { desc = 'git reset buffer' })
            map('n', '<leader>hp', gs.preview_hunk, { desc = 'git preview hunk' })
            map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = 'git blame line' })
            map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'git toggle current line blame' })
            map('n', '<leader>hd', gs.diffthis, { desc = 'git diff index' })
            map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'git diff previous' })

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'in git hunk' })
        end
    }
end
