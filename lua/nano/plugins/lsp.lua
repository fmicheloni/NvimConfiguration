--------------------------
-- Mason
--------------------------
vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
vim.pack.add({ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" })

require("mason").setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  -- Add the servers you want Mason to install for you
  ensure_installed = {
    "lua_ls",
    -- rust_analyzer is intentionally NOT managed by Mason. We use the
    -- rustup-managed binary instead (see lsp/rust_analyzer.lua) so its
    -- proc-macro ABI stays in sync with the active Rust toolchain.
    "bashls",
    "vtsls",
    "basedpyright",
    "ruff",
    "dockerls",
    "eslint",
  },
})

require('mason-tool-installer').setup {
  ensure_installed = {
    'shellcheck',
    'prettierd',
  }
}

--------------------------
-- Native LSP Config
--------------------------
vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('bashls')
vim.lsp.enable('vtsls')
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')
vim.lsp.enable('dockerls')
vim.lsp.enable('eslint')

-- Ensure Dockerfile variants are detected so dockerls attaches
vim.filetype.add({
  filename = { ['Containerfile'] = 'dockerfile' },
  pattern = {
    ['Dockerfile.*'] = 'dockerfile',
    ['.*%.dockerfile'] = 'dockerfile',
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = args.buf }
    -- Completion is handled by blink.cmp (see plugins/completion.lua).
    -- The <C-Space>/<C-n>/<C-p>/<CR> keys are configured there, unchanged.

    -- Inlay hints (parameter names, return types). vtsls already configures
    -- these in lsp/vtsls.lua; this actually turns them on, with a toggle.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      vim.keymap.set('n', '<leader>lh', function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
          { bufnr = args.buf }
        )
      end, opts)
    end

    -- NOTE: <leader>lf is defined in plugins/formatting.lua (conform.nvim),
    -- which formats via Prettier/ruff and falls back to the LSP formatter.

    -- Navigation and info
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)

    -- Refactors and fixes
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Imports (mainly TS/JS via vtsls; harmless no-op where unsupported).
    -- <leader>oi organizes imports; <leader>am adds all missing imports.
    vim.keymap.set('n', '<leader>oi', function()
      vim.lsp.buf.code_action({
        context = { only = { 'source.organizeImports' }, diagnostics = {} },
        apply = true,
      })
    end, opts)
    vim.keymap.set('n', '<leader>am', function()
      vim.lsp.buf.code_action({
        context = { only = { 'source.addMissingImports.ts' }, diagnostics = {} },
        apply = true,
      })
    end, opts)
  end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  severity_sort = true,
  float = { source = true, border = "rounded" },
})

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show line diagnostics" })
