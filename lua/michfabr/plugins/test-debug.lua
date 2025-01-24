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
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dapui = require("dapui")
            local dap = require("dap")

            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
            -- require('dap-python').resolve_python = function()
            --     require("whichpy.envs").current_selected()
            -- end


            local hide_info = function()
                print("hide")
                vim.diagnostic.enable(false)
                vim.api.nvim_command(":Gitsigns toggle_current_line_blame")
            end
            local show_info = function()
                vim.diagnostic.enable()
                vim.api.nvim_command(":Gitsigns toggle_current_line_blame")
            end

            dap.listeners.after.event_initialized["dapui_config"] = function()
                hide_info()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                show_info()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                show_info()
                dapui.close({})
            end
            dapui.setup({
                layouts = {
                    {
                        elements = {
                            {
                                id = "stacks",
                                size = 0.5
                            },
                            {
                                id = "breakpoints",
                                size = 0.25
                            },
                        },
                        position = "left",
                        size = 40
                    },
                    {
                        elements = {
                            {
                                id = "repl",
                                size = 0.5
                            },
                            {
                                id = "scopes",
                                size = 0.5
                            },
                        },
                        position = "bottom",
                        size = 20
                    }
                },
            })
            dap.set_log_level("TRACE")

            vim.fn.sign_define("DapBreakpoint", {
                text = "🅑 ",
                texthl = "",
                linehl = "",
                numhl = ""
            })
        end,
        init = function()
            vim.keymap.set("n", "<leader>dt", function() require('dap-python').test_method() end,
                { desc = "Debug closest test (DAP)" })
            vim.keymap.set("n", '<leader>dc', function() require('dap').continue() end, { desc = "Debug continue" })
            vim.keymap.set("n", '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = "Debug toggle breakpoint" })
            vim.keymap.set("n", '<F6>', function() require('dap').step_over() end, { desc = "Debug step over" })
            vim.keymap.set("n", '<F7>', function() require('dap').step_into() end, { desc = "Debug step into" })
            vim.keymap.set("n", '<F8>', function() require('dap').step_out() end, { desc = "Debug step out" })
        end
    },
}
