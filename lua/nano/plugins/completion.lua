--------------------------
-- Completion (blink.cmp)
--------------------------
-- friendly-snippets provides the VSCode-style snippet library (rafce, useState,
-- ...). blink's snippet source auto-discovers it on the runtimepath.
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })

-- Pin to the 1.x release line for a stable API.
vim.pack.add({
  {
    src = "https://github.com/Saghen/blink.cmp",
    version = vim.version.range("1"),
  },
})

require("blink.cmp").setup({
  -- Keep the existing keys exactly as before (no new mappings):
  --   <C-Space> trigger, <C-n>/<C-p> navigate, <CR> accept.
  keymap = {
    preset = "none",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
  },

  -- Pure-Lua fuzzy matcher: no Rust binary / build step needed (works with
  -- vim.pack, which has no build hooks).
  fuzzy = { implementation = "lua" },

  sources = {
    default = { "lsp", "snippets", "path", "buffer" },
  },
})

-- Advertise blink's completion capabilities (snippets, resolve, etc.) to every
-- server enabled via vim.lsp.enable.
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
})
