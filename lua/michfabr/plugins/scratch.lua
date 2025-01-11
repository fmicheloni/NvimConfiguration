return {
    "LintaoAmons/scratch.nvim",
    event = "VeryLazy",
    dependencies = { "ibhagwan/fzf-lua" },
    init = function ()
        vim.keymap.set("n", "<leader>sfn", "<cmd>Scratch<cr>")
        vim.keymap.set("n", "<leader>sfo", "<cmd>ScratchOpen<cr>")
    end
}
