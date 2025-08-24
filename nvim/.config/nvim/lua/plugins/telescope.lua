return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,  -- грузим сразу
    priority = 1000,
  config = function()
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set

    -- Global Telescope keymaps
    map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
    map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
  end,
}
