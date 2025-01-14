return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
        },
        event = "VeryLazy",
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                        python = function()
                            return require("whichpy.envs").current_selected()
                        end
                    }),
                }
            });
        end,
        init = function()
            -- run test mappings
            vim.keymap.set("n", "<leader>ta", function()
                require("neotest").output_panel.clear()
                require("neotest").run.run(vim.fn.expand("%"))
            end, { desc = "Run file (Neotest)" })
            vim.keymap.set("n", "<leader>tt", function()
                require("neotest").output_panel.clear()
                require("neotest").run.run()
            end, { desc = "Run closest test (Neotest)" })
            vim.keymap.set("n", "<leader>tl", function()
                require("neotest").output_panel.clear()
                require("neotest").run.run_last()
            end, { desc = "Run last executed test (Neotest)" })
            vim.keymap.set("n", "<leader>tp", function() require("neotest").output_panel.toggle() end,
                { desc = "Open / Close test output panel (Neotest)" })

            -- run debug mappings
            -- vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,
            --     { desc = "Debug closest test (Neotest)" })
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local path = "~/miniconda3/envs/pynvim/bin/python"
            require("dap-python").setup(path)
            require('dap-python').resolve_python = function()
                require('dap-python').resolve_python()
            end
        end,
        init = function()
            vim.keymap.set("n", "<leader>td", function() require('dap-python').test_method() end,
                { desc = "Debug closest test (DAP)" })
        end
    },
}
