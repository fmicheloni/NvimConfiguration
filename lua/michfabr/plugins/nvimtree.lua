return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            view = {
                relativenumber = true,
                adaptive_size = true
            },
            disable_netrw = true,
            hijack_netrw = true,
        }
    end,
    init = function()
        vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>", {});
        vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", {})
        vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", {})
        vim.keymap.set("n", "<C-Up>", ":vertical -2<cr>", {})
        vim.keymap.set("n", "<C-Down>", ":vertical +2<cr>", {})
        vim.keymap.set("n", "<TAB>", ":bn!<cr>", {})
        vim.keymap.set("n", "<S-TAB>", "<C-w>w", {})
        vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<cr>", { desc = "Jump to file in the tree" })
    end
}
