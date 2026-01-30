vim.g.mapleader = " "
local keymap = vim.keymap.set

keymap("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })

-- Copy, paste, delete...
keymap("x", "<leader>p", [["_dP]], { desc = "Paste and keep clipboard" })
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })

-- Move up/down selected lines
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- append next line to current one with a space, keep curse in place
keymap("n", "J", "mzJ`z")

-- when jumping around, keep cursor in the middle
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- when doing searches, keep cursor in middle
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- indent
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-tank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- move between windows
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to the window on the left" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to the window on the right" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to the window on top" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to the window on bottom" })

-- quickfix list navigation
-- keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
-- keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
-- keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
-- keymap("n", "<leader>j", "<cmd>lprev<CR>zz")
