local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile' },
  root_markers = { 'Dockerfile', '.git' },
  capabilities = capabilities,
  -- Docker Language Server settings
  settings = {
    docker = {
      languageserver = {
        formatter = {
          -- Leave multiline RUN/COPY instructions untouched when formatting
          ignoreMultilineInstructions = true,
        },
      },
    },
  },
}
