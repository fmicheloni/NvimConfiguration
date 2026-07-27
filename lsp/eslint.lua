-- vscode-eslint-language-server (from vscode-langservers-extracted).
-- Linting only: formatting stays with Prettier/conform (format = false).
-- Provides an on-demand :LspEslintFixAll command, but does NOT run it on save.

local lsp = vim.lsp

return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
  -- Only attach in projects that actually have an ESLint config file,
  -- so ESLint stays completely out of the way in repos without one.
  root_markers = {
    ".eslintrc", ".eslintrc.js", ".eslintrc.cjs",
    ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json",
    "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
    "eslint.config.ts", "eslint.config.mts", "eslint.config.cts",
  },
  workspace_required = true,
  -- https://github.com/Microsoft/vscode-eslint#settings-options
  settings = {
    validate = "on",
    useESLintClass = false,
    experimental = {},
    codeActionOnSave = { enable = false, mode = "all" },
    format = false, -- Prettier/conform owns formatting
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    problems = { shortenToSingleLine = false },
    nodePath = "",
    workingDirectory = { mode = "auto" },
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
  },
  -- The eslint server needs a "workspaceFolder" (a VSCode concept) to know
  -- how far up the tree to look for the ESLint config.
  before_init = function(_, config)
    local root_dir = config.root_dir
    if root_dir then
      config.settings = config.settings or {}
      config.settings.workspaceFolder = {
        uri = vim.uri_from_fname(root_dir),
        name = vim.fn.fnamemodify(root_dir, ":t"),
      }
    end
  end,
  on_attach = function(client, bufnr)
    -- Manual fix-all command. Intentionally NOT wired to BufWritePre.
    vim.api.nvim_buf_create_user_command(bufnr, "LspEslintFixAll", function()
      client:request_sync("workspace/executeCommand", {
        command = "eslint.applyAllFixes",
        arguments = {
          { uri = vim.uri_from_bufnr(bufnr), version = lsp.util.buf_versions[bufnr] },
        },
      }, nil, bufnr)
    end, {})
  end,
  -- Handle the eslint/* server requests so it doesn't error out.
  handlers = {
    ["eslint/openDoc"] = function(_, result)
      if result then vim.ui.open(result.url) end
      return {}
    end,
    ["eslint/confirmESLintExecution"] = function(_, result)
      if not result then return end
      return 4 -- approved
    end,
    ["eslint/probeFailed"] = function()
      vim.notify("ESLint probe failed.", vim.log.levels.WARN)
      return {}
    end,
    ["eslint/noLibrary"] = function()
      vim.notify("Unable to find ESLint library.", vim.log.levels.WARN)
      return {}
    end,
  },
}
