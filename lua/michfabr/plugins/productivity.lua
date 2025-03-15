return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        init = function()
            require("todo-comments").setup({})
        end
    },
    {
        "LintaoAmons/scratch.nvim",
        event = "VeryLazy",
        dependencies = { { "nvim-telescope/telescope.nvim" } },
        init = function()
            vim.keymap.set("n", "<leader>sfn", "<cmd>Scratch<cr>")
            vim.keymap.set("n", "<leader>sfo", "<cmd>ScratchOpen<cr>")
        end
    },
}
