vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    -- Monitor gets executed only after the plugin is loaded.
    -- This is the `main` branch API: no more configs.setup()/auto_install,
    -- parsers must be installed explicitly and highlighting enabled per filetype.
    monitor = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "query",
        "rust",
        "bash",
        "javascript", "typescript", "tsx",
        "python",
        "dockerfile",
        "json", "yaml",
        "html", "css",
        "markdown", "markdown_inline",
      })
    end,
  }
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
