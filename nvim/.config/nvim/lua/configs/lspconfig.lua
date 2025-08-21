-- Basic NvChad config
-- require("nvchad.configs.lspconfig").defaults()
--
-- local servers = { "html", "cssls", "tsx", "pylsp", "clangd" }
-- vim.lsp.enable(servers)

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- list of all servers configured.
local servers = {
    "lua_ls",
    "clangd",
    "pylsp",
    "ts_ls",
    "html",
    "cssls",
}

lspconfig.servers = servers

lspconfig.html.setup {}
lspconfig.cssls.setup {}

lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
}

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                    vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
}

lspconfig.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                mccabe = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                black = { enabled = false },
                pydocstyle = { enabled = false },
                ruff = { enabled = false },
            },
        },
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
lspconfig.ruff.setup {
    root_dir = util.root_pattern("pyproject.toml", ".git", "ruff.toml", "setup.cfg", "requirements.txt")
        or util.path.dirname,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
    end,
}

-- read :h vim.lsp.config for changing options of lsp servers
