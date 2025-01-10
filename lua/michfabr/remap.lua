vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move up/down selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append next line to current one with a space, keep curse in place
vim.keymap.set("n", "J", "mzJ`z")

-- when jumping around, keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- when doing searches, keep cursor in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- indent
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- resize buffers
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", {})
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", {})
vim.keymap.set("n", "<C-Up>", ":vertical -2<cr>", {})
vim.keymap.set("n", "<C-Down>", ":vertical +2<cr>", {})

-- move between buffers
vim.keymap.set("n", "<TAB>", ":bn!<cr>", {})
vim.keymap.set("n", "<S-TAB>", "<C-w>w", {})
vim.keymap.set("n", "<C-ESC>", ":bd<cr>", {})

-- copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

