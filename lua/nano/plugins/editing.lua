--------------------------
-- Autopairs
--------------------------
vim.pack.add({"https://github.com/windwp/nvim-autopairs"})

require("nvim-autopairs").setup({})

--------------------------
-- Autopairs
--------------------------
vim.pack.add({"https://github.com/numToStr/Comment.nvim"})

require("Comment").setup()

vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
  vim.api.nvim_feedkeys("j", "n", false)
end, { desc = "Comment toggle line" })

vim.keymap.set("v", "<leader>/", 
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", 
  { desc = "Comment toggle selection" }
)
