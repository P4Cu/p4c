local opts = { buffer = 0, prefix = "<LocalLeader>", mode = "n" }
local nmap = {
  a = { function() vim.cmd.RustLsp "codeAction" end, "[RUST] Hover actions" },
  T = { function() vim.cmd.RustLsp "openCargo" end, "[Rust] Open toml" },
  h = { function() vim.cmd.RustLsp "openDocs" end, "[Rust] Open docs.rs" },
  r = { function() vim.cmd.RustLsp "runnables" end, "[Rust] runnables" },
  R = { function() vim.cmd.RustLsp "run" end, "[Rust] run under cursor" },
  d = { function() vim.cmd.RustLsp "debuggables" end, "[Rust] debuggables" },
  D = { function() vim.cmd.RustLsp "debug" end, "[Rust] debug under cursor" },
  P = { function() vim.cmd.RustLsp "parentModule" end, "[Rust] parent module" },
}
require("which-key").register(nmap, opts)
