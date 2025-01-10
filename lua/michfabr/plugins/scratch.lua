return {
    "LintaoAmons/scratch.nvim",
    event = "VeryLazy",
    dependencies = { "ibhagwan/fzf-lua" },
    init = function ()
        vim.keymap.set("n", "<C-S-n>", "<cmd>Scratch<cr>")
        vim.keymap.set("n", "<C-S-o>", "<cmd>ScratchOpen<cr>")
    end
}
