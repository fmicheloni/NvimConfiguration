return {
    -- LSP
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "williamboman/mason.nvim" },
        },
        config = function()
            require("mason").setup {}
            require("mason-lspconfig").setup {
                automatic_installation = true,
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "pyright",
                    "ruff",
                    "marksman",
                    "dockerls",
                    "docker_compose_language_service",
                    "jsonls",

                    -- web dev
                    "ts_ls",
                    "eslint",
                    "html",
                    "cssls",
                    "tailwindcss",
                },
            }
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        requires = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "debugpy",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            -- (Optional) Configure lua language server for neovim
            local lspconfig = require("lspconfig")
            local configs = require("lspconfig.configs")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(client, bufnr)
                if client.name == "ruff_lsp" then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end

            -- TODO: enable breadcrumbs to work with multiple tabs -> https://github.com/utilyre/barbecue.nvim/issues/35
            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you"re using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {
                                "vim",
                                "require"
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
            lspconfig.ruff.setup({
                on_attach = on_attach,
            })
            lspconfig.pyright.setup {
                capabilities = capabilities,
                settings = {
                    pyright = {
                        -- Using Ruff"s import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { "*" },
                        },
                    },
                },
            }
            -- NOTE: Barium should be installed as language client
            if not configs.barium then
                configs.barium = {
                    default_config = {
                        cmd = { "barium" },
                        filetypes = { "brazil-config" },
                        root_dir = function(fname)
                            return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
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
                        cmd = { "config-lsp" },
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
            lspconfig.ts_ls.setup({
                capabilities = capabilities
            })
            lspconfig.eslint.setup {}
            lspconfig.html.setup {}
            lspconfig.cssls.setup {}
            lspconfig.tailwindcss.setup {}
            lspconfig.dockerls.setup {}
            lspconfig.docker_compose_language_service.setup {}
        end,
        init = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })
        end
    }
}
