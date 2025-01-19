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
    }
}

local function config()
    require('nvim-treesitter.configs').setup(opts)
end

return {
    -- TODO: just a test todo
    -- FIX: fix this
    -- HACK: asd
    -- NOTE: random comment
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        -- -@module "ibl"
        -- -@type ibl.config
        opts = {},
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
        opts = { -- set to setup table
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = config,
        build = ':TSUpdate',
    },
    -- folding stuff
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        opts = {
            hOnlyOpensOnFirstColumn = true,
        }, -- needed even when using default config
    },
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
                            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                            { text = { "%s" }, click = "v:lua.ScSa" },
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
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
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
    -- Folding preview, by default h and l keys are used.
    -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
    -- On second press the preview will be closed and fold will be opened.
    -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
    { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
}
