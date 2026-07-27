--------------------------
-- Formatting (conform)
--------------------------
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript      = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript      = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    css             = { "prettierd", "prettier", stop_after_first = true },
    json            = { "prettierd", "prettier", stop_after_first = true },
    markdown        = { "prettierd", "prettier", stop_after_first = true },
    -- Python: ruff (already installed via Mason). Both run in order:
    -- sort imports, then format. No stop_after_first (they're complementary).
    python          = { "ruff_organize_imports", "ruff_format" },
  },
  -- Save: only auto-format filetypes with a real formatter above.
  -- lsp_format intentionally omitted so non-configured filetypes are
  -- NOT reformatted on save (predictable, no surprise diffs).
  format_on_save = { timeout_ms = 1000 },
})

-- Manual format = same path as save, but universal:
-- Prettier/ruff where configured, LSP formatter (lua_ls, rust_analyzer, ...)
-- as fallback everywhere else. Also works on a visual selection (range format).
vim.keymap.set({ "n", "v" }, "<leader>lf", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer/selection" })
