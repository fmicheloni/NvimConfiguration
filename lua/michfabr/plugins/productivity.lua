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
    {
        "ojroques/nvim-osc52",
        config = function()
            require("osc52").setup {
                max_length = 0, -- Maximum length of selection (0 for no limit)
                silent = false,
                trim = false,
            }
            local function copy()
                if ((vim.v.event.operator == "y" or vim.v.event.operator == "d")
                        and vim.v.event.regname == "") then
                    require("osc52").copy_register("")
                end
            end

            vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
        end,
    }
}
