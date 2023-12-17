-- TODO: info how to provide default on_attach!
--   https://www.reddit.com/r/neovim/comments/wdiv4p/setting_up_neovim_with_lsp_and_clangd/

local function map(mode, l, r, description)
    vim.keymap.set(mode, l, r, { buffer = buffer, desc = description })
end

local function nmap(key, action, desc)
    vim.keymap.set("n", key, action, { buffer = buffnr, desc = desc })
end

return {
    -- TODO: can be lazy
    { "williamboman/mason.nvim",  config = {} },
    -- TODO: bridging lspconfig and mason via https://github.com/williamboman/mason-lspconfig.nvim

    { "folke/neodev.nvim", opts = {}, },

    { "ray-x/lsp_signature.nvim", },

    -- TODO: fix all the mess with lsp config and loading of lsp
    {
        "neovim/nvim-lspconfig",
        dependencies = { "folke/neodev.nvim", "williamboman/mason.nvim", "ray-x/lsp_signature.nvim" },
        config = function()
            local function on_attach(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("lsp_signature").on_attach({
                        bind = true,
                    }, buffer)
                end

                -- TODO: enable inlay_hints always? and add a toggle in <localleader>

                -- TODO: take map from mappings.lua or simply map it there (but then it's not attached)
                -- Code navigation and shortcuts
                map("n", "K", vim.lsp.buf.hover, "Hover")
                map("n", "gD", vim.lsp.buf.implementation, "Go to implementation")
                map("n", "gS", vim.lsp.buf.signature_help, "Signature")
                map("n", "1gD", vim.lsp.buf.type_definition, "Go to type-definition")
                map("n", "gr", vim.lsp.buf.references, "Find references")
                map("n", "gR", vim.lsp.buf.rename, "Rename symbol")
                map("n", "g0", vim.lsp.buf.document_symbol, "Document symbol")
                map("n", "gW", vim.lsp.buf.workspace_symbol, "Workspace symbol")
                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "ga", vim.lsp.buf.code_action, "Code actions")
                map("n", "<F4>", "<CMD>ClangdSwitchSourceHeader<CR>", "Switch Source Header")
                map("n", "<F8>", vim.diagnostic.goto_next, "Next diagnostic")
                map("n", "<F20>", vim.diagnostic.goto_prev, "Previous diagnostic")
                map("n", "<LocalLeader>f", function() vim.lsp.buf.format { async = true } end, "Format code")

                -- Show diagnostic popup on cursor hover
                local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
                vim.api.nvim_create_autocmd("CursorHold", {
                    callback = function()
                        vim.diagnostic.open_float(nil, { focusable = true })
                    end,
                    group = diag_float_grp,
                })
            end

            -- use mason to get external tools
            require('lspconfig').clangd.setup { on_attach = on_attach }
            require('lspconfig').pyright.setup { on_attach = on_attach }                         -- pip install pyright
            require('lspconfig').bashls.setup { on_attach = on_attach }                          -- npm i -g bash-language-server
            require('lspconfig').cmake.setup { on_attach = on_attach }
            require('lspconfig').dockerls.setup { on_attach = on_attach }                        -- npm install -g dockerfile-language-server-nodejs
            require('lspconfig').docker_compose_language_service.setup { on_attach = on_attach } -- npm install @microsoft/compose-language-service

            -- configured for neovim completions
            require('lspconfig').lua_ls.setup {
                on_attach = on_attach,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        }
                    }
                }
            }
        end,
    },

    {
        "simrat39/rust-tools.nvim",
        ft = { 'rust', 'toml' },
        dependencies = { "neovim/nvim-lspconfig", },
        config = {
            -- all the opts to send to nvim-lspconfig
            -- these override the defaults set by rust-tools.nvim
            -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
            server = {
                on_attach = function(client, buffnr)
                    -- default actions
                    on_attach(client, buffnr)
                    -- custom actions only for rust
                    -- TODO: mapping.lua should return mappable and we should use it here
                    nmap("<LocalLeader>a", rt.hover_actions.hover_actions, '[Rust] action')
                    nmap("<LocalLeader>t", rt.open_cargo_toml.open_cargo_toml, "[Rust] open toml")
                    nmap("<LocalLeader>r", rt.runnables.runnables, "[Rust] runnables")
                    nmap("<LocalLeader>p", rt.parent_module.parent_module, "[Rust] parent module")
                end,
                settings = {
                    -- to enable rust-analyzer settings visit:
                    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                    ["rust-analyzer"] = {
                        -- enable clippy on save
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },
            -- no dap setup here - done in dap.lua - this would be dap.adapters.rt_lldb
            dap = { adapter = false, }
        }
    },

    {
        -- TODO: needs replacement https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
        -- maybe guard nvim?
        -- TODO: it can also do formatting
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            null_ls.setup({
                -- on_attach = on_attach({ format = true }),
                sources = {
                    diagnostics.shellcheck,
                    diagnostics.pylint,
                    diagnostics.flake8,
                    formatting.black,
                    formatting.rustfmt,
                },
            })
        end
    },
}
