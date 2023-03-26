local navic = require("nvim-navic")

local function on_attach(client, buffer)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, buffer)
  end

  local keymap_opts = { buffer = buffer }
  -- Code navigation and shortcuts
  vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
  vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
  vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
  vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)

  -- Show diagnostic popup on cursor hover
  local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = true })
    end,
    group = diag_float_grp,
  })

  -- Goto previous/next diagnostic warning/error
  vim.keymap.set("n", "<F20>", vim.diagnostic.goto_prev, keymap_opts)
  vim.keymap.set("n", "<F8>", vim.diagnostic.goto_next, keymap_opts)
end

-- use mason to get external tools
require("mason").setup()
require('lspconfig').clangd.setup { on_attach = on_attach }
require('lspconfig').pyright.setup { on_attach = on_attach }                         -- pip install pyright
require('lspconfig').bashls.setup { on_attach = on_attach }                          -- npm i -g bash-language-server
require('lspconfig').cmake.setup { on_attach = on_attach }
require('lspconfig').dockerls.setup { on_attach = on_attach }                        -- npm install -g dockerfile-language-server-nodejs
require('lspconfig').docker_compose_language_service.setup { on_attach = on_attach } -- npm install @microsoft/compose-language-service

-- configured for neovim completions
require 'lspconfig'.lua_ls.setup {
  on_attach = on_attach,
}

-- configures nvim-lspconfig for us
require("rust-tools").setup {
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    on_attach = on_attach, -- this is exception
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
}


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
