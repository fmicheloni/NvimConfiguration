local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  -- Command to start the server. Use the rustup-managed binary (installed via
  -- `rustup component add rust-analyzer`) so its proc-macro ABI always matches
  -- the active toolchain. Mason prepends its own bin/ to Neovim's PATH, so a
  -- bare 'rust-analyzer' would resolve to Mason's (often stale) copy instead.
  cmd = { vim.fn.expand('~/.cargo/bin/rust-analyzer') },

  -- Filetypes to automatically attach to.
  filetypes = { 'rust' },

  -- Root of a Rust project: the package/workspace manifest, else the git root.
  root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },

  capabilities = capabilities,

  -- Server-specific settings. Schema:
  -- https://rust-analyzer.github.io/manual.html#configuration
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        -- Pull in all Cargo features for analysis.
        allFeatures = true,
      },
      check = {
        -- Use clippy for on-save diagnostics (falls back to `check` if clippy
        -- is not installed). Run `rustup component add clippy` to enable it.
        command = 'clippy',
      },
      inlayHints = {
        -- The LspAttach handler in plugins/lsp.lua turns these on per-buffer.
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
