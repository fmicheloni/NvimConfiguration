local opts = {
    ensure_installed = {
        'c',
        'lua',
        'vim',
        'vimdoc',
        'query',
        'markdown',
        'markdown_inline',
        'html',
        'css',
        'javascript',
        'java',
        'kotlin',
        'typescript',
        'tsx',
        'rust',
        'python',
        'json',
        'ssh_config',
        'bash',
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            -- scope_incremental = '<C-L>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
        }
    }
}

local function config()
    require('nvim-treesitter.configs').setup(opts)
end

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = false,
                },
            })
        end
    },
    {
        -- highlights words corresponding to the selected word
        'RRethy/vim-illuminate',
        config = function()
            require('illuminate').configure({})
        end
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = config,
        build = ':TSUpdate',
    },
    -- folding stuff
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
                            { text = { "%s" },                  click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        },
                    })
                end,
            },
        },
        event = "BufReadPost",
        opts = {
            provider_selector = function()
                return { "treesitter", "indent" }
            end,
        },

        init = function()
            -- UFO folding
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:>]]

            vim.keymap.set("n", "zR", function()
                require("ufo").openAllFolds()
            end)
            vim.keymap.set("n", "zM", function()
                require("ufo").closeAllFolds()
            end)
        end,
    },
}
