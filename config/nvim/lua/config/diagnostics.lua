vim.diagnostic.config {
  virtual_text = false,
  -- signs = {
  -- active = signs,
  -- },
  signs = true,
  underline = { severity = { min = vim.diagnostic.severity.ERROR } },
  severity_sort = true,
  float = {
    -- style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}
