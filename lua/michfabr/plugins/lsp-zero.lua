return {
    -- Autocompletion
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets'
        }
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({ ---@diagnostic disable-line: redundant-parameter
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(), -- open completion menu
                    ['<C-f>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
                    ['<C-b>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })
        end
    },
    -- {
    --     'saghen/blink.cmp',
    --     -- optional: provides snippets for the snippet source
    --     dependencies = 'rafamadriz/friendly-snippets',
    --
    --     -- use a release tag to download pre-built binaries
    --     version = '*',
    --     -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    --     -- build = 'cargo build --release',
    --     -- If you use nix, you can build from source using latest nightly rust with:
    --     -- build = 'nix run .#build-plugin',
    --
    --     ---@module 'blink.cmp'
    --     opts = {
    --         -- 'default' for mappings similar to built-in completion
    --         -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    --         -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    --         -- See the full "keymap" documentation for information on defining your own keymap.
    --         keymap = {
    --             ["<C-Space>"] = { "show" },
    --             ["<C-h>"] = { "hide", "hide_documentation" },
    --             ["<C-y>"] = { "select_and_accept", "fallback" },
    --             ["<C-f>"] = { "select_next", "fallback" },
    --             ["<C-b>"] = { "select_prev", "fallback" },
    --             ["<C-u>"] = { "cancel" },
    --             ["<C-k>"] = { "show_documentation" },
    --             ["<PageDown>"] = { "scroll_documentation_down" },
    --             ["<PageUp>"] = { "scroll_documentation_up" },
    --         },
    --         appearance = {
    --             -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    --             -- Useful for when your theme doesn't support blink.cmp
    --             -- Will be removed in a future release
    --             use_nvim_cmp_as_default = true,
    --             -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    --             -- Adjusts spacing to ensure icons are aligned
    --             nerd_font_variant = 'mono'
    --         },
    --
    --         -- Default list of enabled providers defined so that you can extend it
    --         -- elsewhere in your config, without redefining it, due to `opts_extend`
    --         sources = {
    --             default = { 'lsp', 'path', 'snippets', 'buffer' },
    --         },
    --     },
    --     opts_extend = { "sources.default" },
    -- },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'williamboman/mason.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            require('mason').setup {}
            require('mason-lspconfig').setup {
                automatic_installation = true,
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "pyright",
                    "marksman",
                },
            }

            -- (Optional) Configure lua language server for neovim
            local lspconfig = require('lspconfig')
            local configs = require('lspconfig.configs')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {
                                'vim',
                                'require'
                            },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
            lspconfig.pyright.setup({
                capabilities = capabilities
            })
            -- NOTE: Barium should be installed as language client
            if not configs.barium then
                configs.barium = {
                    default_config = {
                        cmd = { 'barium' },
                        filetypes = { 'brazil-config' },
                        root_dir = function(fname)
                            return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
                        end,
                        settings = {},
                    },
                }
            end
            lspconfig.barium.setup {}
            lspconfig.marksman.setup({
                capabilities = capabilities
            })
            if not configs.config_lsp then
                configs.config_lsp = {
                    default_config = {
                        cmd = { 'config-lsp' },
                        filetypes = {
                            "sshconfig",
                            "sshdconfig",
                            "fstab",
                            "aliases",
                            -- Matches wireguard configs and /etc/hosts
                            "conf",
                        },
                        root_dir = vim.loop.cwd,
                    },
                }
            end
            lspconfig.config_lsp.setup {}
        end,
        init = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })
        end
    }
}
