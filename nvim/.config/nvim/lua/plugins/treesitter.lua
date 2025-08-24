return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            auto_install = true,
            ensure_installed = {
                "cpp",
                "python",
                "css",
                "html",
                "javascript",
                "typescript",
                "lua",
                "json",
            },
            highlight = { enable = true },
            indent = { enable = true },
            rainbow = {
                enable = true,
                extended_mode = true, -- для <> и других скобок
                max_file_lines = nil, -- ограничение по размеру файла
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
