return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require "cmp"
        local luasnip = require "luasnip"
        local lspkind = require "lspkind"

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup {
            completion = { completeopt = "menu,menuone,preview,noselect" },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm { select = true },
            },
            sources = cmp.config.sources {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "luasnip" },
            },
            formatting = {
                format = lspkind.cmp_format {
                    mode = "symbol_text",
                    maxwidth = 75,
                    ellipsis_char = "...",
                },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        }

        -- === Настройка для command line ===
        -- Поиск ("/" или "?")
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Командная строка (":")
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end,
}
