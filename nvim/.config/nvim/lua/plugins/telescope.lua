return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false, -- грузим сразу
    config = function()
        local builtin = require "telescope.builtin"
        local map = vim.keymap.set

        -- Global Telescope keymaps
        map("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
        map("n", "<leader>fr", builtin.oldfiles, { desc = "[S]earch recent files" })
        map("n", "<leader>fg", builtin.live_grep, { desc = "[S]earch [G]rep" })
        map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        map("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        map("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        map(
            "n",
            "<leader>/",
            builtin.current_buffer_fuzzy_find,
            { desc = "Search in current buffer" }
        )
    end,
    event = "VeryLazy",
}
