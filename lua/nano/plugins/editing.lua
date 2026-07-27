--------------------------
-- Autopairs
--------------------------
vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

require("nvim-autopairs").setup({})

--------------------------
-- Auto tag (JSX/TSX/HTML)
--------------------------
vim.pack.add({ "https://github.com/windwp/nvim-ts-autotag" })

require("nvim-ts-autotag").setup()

--------------------------
-- Comment
--------------------------
vim.pack.add({ "https://github.com/numToStr/Comment.nvim" })

require("Comment").setup()

vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
  vim.api.nvim_feedkeys("j", "n", false)
end, { desc = "Comment toggle line" })

vim.keymap.set("v", "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment toggle selection" }
)
