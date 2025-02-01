-- Autocompletion framework
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- cmp LSP completion
        "hrsh7th/cmp-nvim-lsp",
        -- cmp Snippet completion
        "hrsh7th/cmp-vsnip",
        -- cmp Path completion
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        -- See hrsh7th other plugins for more great completion sources!
        -- Snippet engine
        'hrsh7th/vim-vsnip',
    },
    config = function()
        -- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                -- Add tab support
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = false, -- do not insert if not selected
                }),
            },
            -- Installed sources
            sources = {
                { name = "nvim_lsp" },
                { name = "vsnip" },
                { name = "path" },
                { name = "buffer" },
            },
        })
    end
}
