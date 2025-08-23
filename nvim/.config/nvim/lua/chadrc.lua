-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "gruvbox",
    transparency = false,
    integrations = { "dap" },

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
}

M.nvdash = { load_on_startup = true }
M.ui = {
    tabufline = {
        lazyload = false,
        bufwidth = 25,
    },
}

M.mason = {
    pkgs = {
        "lua-language-server",
        "stylua",
        "html",
        "cssls",
        "prettierd",
        "pylsp",
        "clangd",
        "clang-format",
        "codelldb", -- debuger for cpp
        "ts_ls",
    },
}

return M
