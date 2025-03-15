return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require('notify').setup({
                -- other stuff
                background_colour = "#000000"
            })

            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                variant = "moon",
                dark_variant = "moon"
            })
            vim.cmd("colorscheme rose-pine")
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        init = function()
            -- logic for getting the configured interpreter. Should support multiple languages, depending on the selected file.
            local current_python_interpreter = require("whichpy.envs").current_selected()
            local shorten_path = function(full_path, max_dirs)
                local parts = {}
                for part in full_path:gmatch("[^/]+") do
                    table.insert(parts, part)
                end
                if #parts > max_dirs then
                    local result = {}
                    for i = math.max(1, #parts - max_dirs + 1), #parts do
                        table.insert(result, parts[i])
                    end
                    return "../" .. table.concat(result, "/")
                end
                return full_path
            end
            local ConfiguredInterpreter = function()
                if current_python_interpreter ~= nil then
                    return shorten_path(current_python_interpreter, 6)
                end
                return ''
            end

            require('lualine').setup({
                sections = {
                    lualine_c = { { 'filename', path = 1 } },
                    lualine_x = { ConfiguredInterpreter, 'encoding', 'fileformat', 'filetype' }
                }
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
}
