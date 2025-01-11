return {
    "tpope/vim-fugitive",
    init = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
        vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "Git blame" })
    end
}
