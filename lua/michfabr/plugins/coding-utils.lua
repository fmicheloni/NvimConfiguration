return {
    {
        'numToStr/Comment.nvim',
        opts = {
        },
        init = function()
            local esc = vim.api.nvim_replace_termcodes(
                '<ESC>', true, false, true
            )

            vim.keymap.set("n", "<leader>/", function()
                require("Comment.api").toggle.linewise.current()
            end, { noremap = true, silent = true })
            vim.keymap.set("v", "<leader>/", function()
                vim.api.nvim_feedkeys(esc, 'nx', false)
                require("Comment.api").toggle.linewise(vim.fn.visualmode())
            end, { noremap = true, silent = true })
        end
    },
    {
        "LintaoAmons/scratch.nvim",
        event = "VeryLazy",
        dependencies = { "ibhagwan/fzf-lua" },
        init = function()
            vim.keymap.set("n", "<leader>sfn", "<cmd>Scratch<cr>")
            vim.keymap.set("n", "<leader>sfo", "<cmd>ScratchOpen<cr>")
        end
    },
}
