vim.pack.add({"https://github.com/nvim-tree/nvim-web-devicons"})
vim.pack.add({"https://github.com/rose-pine/neovim"})

require("rose-pine").setup({
  variant = "moon",
  dark_variant = "moon",
})

vim.cmd("colorscheme rose-pine")
