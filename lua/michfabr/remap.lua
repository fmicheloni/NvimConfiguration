vim.g.mapleader = " "

--- reload file
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "Reload current file" })

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
vim.keymap.set("n", "<C-Up>", ":horizontal resize -2<cr>", {})
vim.keymap.set("n", "<C-Down>", ":horizontal resize +2<cr>", {})

-- move between buffers
vim.keymap.set("n", "<TAB>", ":bn!<cr>", {})
vim.keymap.set("n", "<S-TAB>", "<C-w>w", {})
vim.keymap.set("n", "<leader>bd", ":bd | bn!<cr>", {})

-- copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-tank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the window on the left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the window on the right" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the window on top" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the window on bottom" })
