local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  -- Command and arguments to start the server.
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  -- Uses the current file's directory as fallback
  root_markers = { '.git' },
  capabilities = capabilities,
  -- Bash Language Server settings
  -- Schema: https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
  settings = {
    bashIde = {
      -- Glob pattern for matching shell script files
      globPattern = '*@(.sh|.inc|.bash|.command|.zsh)',
      -- Enable/disable shellcheck integration
      shellcheckPath = 'shellcheck',
      -- ShellCheck arguments
      shellcheckArguments = '',
      -- Enable explainshell integration for hover documentation
      explainshellEndpoint = '',
    }
  }
}
