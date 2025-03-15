return {
    -- Autocompletion
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets"
        }
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            -- And you can configure cmp even more, if you want to.
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({ ---@diagnostic disable-line: redundant-parameter
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<C-Space>"] = cmp.mapping.complete(), -- open completion menu
                    ["<C-f>"] = cmp.mapping.select_next_item({ behavior = "select" }),
                    ["<C-b>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                    { name = "buffer" },
                })
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {
        },
        init = function()
            local esc = vim.api.nvim_replace_termcodes(
                "<ESC>", true, false, true
            )

            vim.keymap.set("n", "<leader>/", function()
                require("Comment.api").toggle.linewise.current()
            end, { noremap = true, silent = true })
            vim.keymap.set("v", "<leader>/", function()
                vim.api.nvim_feedkeys(esc, "nx", false)
                require("Comment.api").toggle.linewise(vim.fn.visualmode())
            end, { noremap = true, silent = true })
        end
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        config = function()
            require("refactoring").setup()
        end,
        init = function()
            require("telescope").load_extension("refactoring")
            vim.keymap.set("v", "<leader>r", function()
                    require("telescope").extensions.refactoring.refactors()
                end,
                { noremap = true, silent = true })
        end
    },
}
