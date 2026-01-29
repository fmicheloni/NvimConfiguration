vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    -- Monitor gets executed only after the plugin is loaded
    monitor = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  }
})
