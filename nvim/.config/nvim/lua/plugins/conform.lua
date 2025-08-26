return {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-conform.nvim" },
    config = function()
        local conform = require "conform"

        -- Настройка форматации по типам файлов
        conform.setup {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                html = { "prettierd" }, -- HTML
                css = { "prettierd" }, -- CSS
                javascript = { "prettierd" }, -- JS
                typescript = { "prettierd" }, -- TS
                json = { "prettierd" },
                cpp = { "clang-format" }, -- C++
                xml = { "xmlformatter" },
            },
            format_on_save = true, -- автоформатирование при сохранении
        }

        -- Настройка mason-conform
        require("mason-conform").setup {
            ensure_installed = { "stylua", "ruff", "prettierd", "clang-format" },
            automatic_installation = true,
        }

        local map = vim.keymap.set
        map("n", "<leader>f", function()
            require("conform").format { async = true }
        end, { desc = "Format buffer" })
    end,
    event = { "BufWritePre", "BufReadPost" }, -- lazy-load
}
