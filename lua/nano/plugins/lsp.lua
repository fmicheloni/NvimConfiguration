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
    "rust_analyzer",
    "bashls",
    "vtsls",
  },
})

require('mason-tool-installer').setup {
  ensure_installed = {
    'shellcheck',
  }
}

--------------------------
-- Native LSP Config
--------------------------
vim.lsp.enable('lua_ls')
vim.lsp.enable('bashls')
vim.lsp.enable('vtsls')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = args.buf }
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)

      -- Navigate the completion menu
      vim.keymap.set('i', '<C-n>', function()
        return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-n>'
      end, { expr = true, buffer = args.buf })

      vim.keymap.set('i', '<C-p>', function()
        return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-p>'
      end, { expr = true, buffer = args.buf })

      -- Select/Confirm the completion
      vim.keymap.set('i', '<CR>', function()
        return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
      end, { expr = true, buffer = args.buf })
    end

    -- Format the current buffer
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
      vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end

    -- Navigation and info
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)

    -- Refactors and fixes
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
  end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  severity_sort = true,
})
