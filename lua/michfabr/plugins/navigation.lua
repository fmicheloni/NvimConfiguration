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
            vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>", {});
            vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", {})
            vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", {})
            vim.keymap.set("n", "<C-Up>", ":vertical -2<cr>", {})
            vim.keymap.set("n", "<C-Down>", ":vertical +2<cr>", {})
            vim.keymap.set("n", "<TAB>", ":bn!<cr>", {})
            vim.keymap.set("n", "<S-TAB>", "<C-w>w", {})
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
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = false,
        init = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>pf", builtin.find_files, {})

            vim.keymap.set("n", "<C-p>", builtin.git_files, {})

            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end
            )
        end,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        init = function()
            require('bufferline').setup {
                options = {
                    hover = {
                        enabled = false,
                    }
                }
            }
        end
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
    }
}
