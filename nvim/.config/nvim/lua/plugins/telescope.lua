return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false, -- грузим сразу
    config = function()
        local telescope = require "telescope"
        local builtin = require "telescope.builtin"
        local map = vim.keymap.set

        telescope.setup {
            defaults = {
                layout_strategy = "horizontal", -- или "vertical", "flex"
                layout_config = {
                    horizontal = {
                        prompt_position = "bottom",
                        preview_width = 0.5, -- ширина preview окна (60%)
                        results_width = 0.5, -- ширина results окна (40%)
                    },
                    vertical = {
                        preview_height = 0.5,
                    },
                    width = 0.9, -- общая ширина окна
                    height = 0.9, -- общая высота окна
                    preview_cutoff = 120,
                },
                sorting_strategy = "ascending",
            },
        }

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

        -- Горизонтальный сплит через Telescope
        map("n", "<leader>fh", function()
            builtin.find_files {
                attach_mappings = function(_, map)
                    map("i", "<CR>", function(prompt_bufnr)
                        local action_state = require "telescope.actions.state"
                        local actions = require "telescope.actions"
                        local entry = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        vim.cmd("split " .. entry.path)
                    end)
                    return true
                end,
            }
        end, { desc = "Find file in horizontal split" })

        -- Вертикальный сплит через Telescope
        map("n", "<leader>fv", function()
            builtin.find_files {
                attach_mappings = function(_, map)
                    map("i", "<CR>", function(prompt_bufnr)
                        local action_state = require "telescope.actions.state"
                        local actions = require "telescope.actions"
                        local entry = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        vim.cmd("vsplit " .. entry.path)
                    end)
                    return true
                end,
            }
        end, { desc = "Find file in vertical split" })
    end,
    event = "VeryLazy",
}
