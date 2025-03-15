return {
    {
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
            vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>", { desc = "Toggle project tree" });
            vim.keymap.set("n", "<TAB>", ":bn!<cr>", {})
            vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<cr>", { desc = "Jump to file in the tree" })
        end
    },
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon"):setup()
        end,
        init = function()
            local harpoon = require("harpoon")

            vim.keymap.set("n", "<leader>A", function() harpoon:list():add() end, {})
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {})
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {})
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {})
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {})
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {})
            vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, {})
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        init = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file in scope" })

            vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "Find file in git" })

            vim.keymap.set("n", "<leader>fg", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end, { desc = "Find grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
        end,
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "bassamsdata/namu.nvim",
        config = function()
            require("namu").setup({
                namu_symbols = {
                    enable = true,
                    options = {},
                },

                colorscheme = {
                    enable = false,
                    options = {
                        persist = true,
                        write_shada = false,
                    },
                },
                ui_select = { enable = false },
            })

            vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
                desc = "Jump to LSP symbol",
                silent = true,
            })
            vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
                desc = "Colorscheme Picker",
                silent = true,
            })
        end,
    },
    {
        "mbbill/undotree",
        init = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    }
}
