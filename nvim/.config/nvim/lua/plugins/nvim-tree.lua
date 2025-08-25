return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        require("nvim-tree").setup {
            hijack_cursor = true,
            hijack_netrw = true,
            update_focused_file = { enable = true },
            view = { width = 35, side = "left" },
        }
    end,
}
