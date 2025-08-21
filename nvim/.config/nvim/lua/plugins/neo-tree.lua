require("window-picker").setup({
    autoselect_one = false,
    include_current = false,
    filter_rules = {
        bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" },
        },
    },
    other_win_hl_color = "#e35e4f",
})

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
    window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
        -- possible options. These can also be functions that return these options.
        position = "left", -- left, right, top, bottom, float, current
        width = 40, -- applies to left and right positions
        height = 15, -- applies to top and bottom positions
        auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
        popup = { -- settings that apply to float position only
            size = {
                height = "80%",
                width = "50%",
            },
            position = "50%", -- 50% means center it
            title = function(state) -- format the text that appears at the top of a popup window
                return "Neo-tree " .. state.name:gsub("^%l", string.upper)
            end,
            -- you can also specify border here, if you want a different setting from
            -- the global popup_border_style.
        },
        same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
        insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
        -- "child":   Insert nodes as children of the directory under cursor.
        -- "sibling": Insert nodes  as siblings of the directory under cursor.
        -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
        -- You can also create your own commands by providing a function instead of a string.
    },
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    },
})
