return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope.nvim", -- alpha зависит от биндов telescope
    },
    config = function()
        local alpha = require "alpha"
        local dashboard = require "alpha.themes.dashboard"

        -- Логотип NeoVim с Powerline
        dashboard.section.header.val = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
        }

        -- Верхний отступ, чтобы поднять чуть выше центра
        dashboard.opts.layout[1].val = 4 -- чем меньше число, тем выше

        -- Кнопки Telescope
        dashboard.section.buttons.val = {
            dashboard.button("ff", "  Find File", ":Telescope find_files<CR>"),
            dashboard.button("fr", "  Recent Files", ":Telescope oldfiles<CR>"),
            dashboard.button("fg", "  Live Grep", ":Telescope live_grep<CR>"),
            dashboard.button("fs", "  All Pickers", ":Telescope builtin<CR>"),
            dashboard.button("fk", "  Keymaps", ":Telescope keymaps<CR>"),
            dashboard.button("fd", "  Diagnostics", ":Telescope diagnostics<CR>"),
            dashboard.button("q", "  Quit NeoVim", ":qa<CR>"),
        }

        require("alpha").setup(dashboard.opts)
    end,
}
