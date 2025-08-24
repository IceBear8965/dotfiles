return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ruff",
                    "clangd",
                    "cssls",
                    "ts_ls",
                    "html",
                    "emmet_ls",
                },
                automatic_enable = false,
            }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require "lspconfig"
            local util = require "lspconfig.util"

            -- === НАСТРОЙКА ДИАГНОСТИК ===
            vim.diagnostic.config {
                virtual_text = {
                    prefix = "●",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            }
            vim.opt.signcolumn = "yes"

            -- Настройки серверов(работает -- не лезь, убьет)
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                vim.fn.expand "$VIMRUNTIME/lua",
                                vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                                vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                                "${3rd}/love2d/library",
                            },
                            maxPreload = 100000,
                            preloadFileSize = 20000,
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            lspconfig.pyright.setup {
                capabilities = vim.tbl_deep_extend(
                    "force",
                    vim.lsp.protocol.make_client_capabilities(),
                    { offsetEncoding = { "utf-16" } } -- Pyright любит UTF-16
                ),
                python = {
                    venvPath = ".",
                    venv = ".venv",
                },
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                end,
            }

            lspconfig.ruff.setup {
                capabilities = vim.tbl_deep_extend(
                    "force",
                    vim.lsp.protocol.make_client_capabilities(),
                    { offsetEncoding = { "utf-16" } } -- Приводим Ruff к UTF-16
                ),
                root_dir = lspconfig.util.root_pattern(
                    "pyproject.toml",
                    ".git",
                    "ruff.toml",
                    "setup.cfg",
                    "requirements.txt"
                ) or lspconfig.util.path.dirname,
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                end,
            }

            lspconfig.html.setup {}
            lspconfig.emmet_ls.setup {
                filetypes = {
                    "html",
                    "css",
                    "javascript",
                    "javascriptreact",
                    "typescriptreact",
                    "vue",
                    "svelte",
                },
            }
            lspconfig.cssls.setup {}

            lspconfig.clangd.setup {
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            }
            -- LSP Keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = function(event)
                    local builtin = require "telescope.builtin"
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(
                            mode,
                            keys,
                            func,
                            { buffer = event.buf, desc = "[LSP] " .. desc }
                        )
                    end

                    -- чистый переход (не Telescope)
                    map("gd", vim.lsp.buf.definition, "Goto Definition")
                    map("gD", vim.lsp.buf.declaration, "Goto Declaration")

                    -- Telescope-шные
                    map("gr", builtin.lsp_references, "Goto References")
                    map("gI", builtin.lsp_implementations, "Goto Implementation")
                    map("<leader>D", builtin.lsp_type_definitions, "Type Definition")

                    -- Остальные
                    map("<leader>rn", vim.lsp.buf.rename, "Rename")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
                    map("K", vim.lsp.buf.hover, "Hover Documentation")

                    vim.keymap.set("n", "<leader>d", function()
                        vim.diagnostic.open_float(0, {
                            focusable = true, -- позволяет фокусироваться на окне
                            scope = "line", -- показываем только текущую строку
                            border = "rounded", -- скруглённая рамка
                            source = "always", -- показывать источник диагностики (например, ruff, pylsp)
                        })
                    end, { desc = "Show diagnostics under cursor with focus" })
                end,
            })

            -- В конце файла после настройки серверов и keymaps
            -- Авто-импорт для Python через Pyright
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.py",
                callback = function()
                    local params = vim.lsp.util.make_range_params(nil, "utf-16") -- Указываем UTF-16
                    params.context = { only = { "source.addMissingImports.pyright" } }
                    local clients =
                        vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }
                    for _, client in ipairs(clients) do
                        if client.name == "pyright" then
                            local results = client.request_sync(
                                "textDocument/codeAction",
                                params,
                                1000,
                                vim.api.nvim_get_current_buf()
                            )
                            if results and results[vim.api.nvim_get_current_buf()] then
                                for _, res in ipairs(results[vim.api.nvim_get_current_buf()]) do
                                    if res.edit then
                                        vim.lsp.util.apply_workspace_edit(res.edit)
                                    end
                                end
                            end
                        end
                    end
                end,
            })
        end,
    },
}
