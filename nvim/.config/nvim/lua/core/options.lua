vim.g.colorscheme = "catppuccin"

-- Устанавливаем Space как основной leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "  -- локальный leader для буферов

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Fonts for webdev-icons
vim.g.have_nerd_font = true

vim.opt.wrap = true

-- Shell
vim.opt.shell = "/bin/zsh"

-- Tab width
vim.opt.expandtab = true       -- вставлять пробелы вместо табов
vim.opt.shiftwidth = 4         -- количество пробелов при автоотступе
vim.opt.tabstop = 4            -- количество пробелов на таб
vim.opt.softtabstop = 4        -- табы при редактировании
vim.opt.autoindent = true      -- наследовать отступ от предыдущей строки
vim.opt.smartindent = true     -- умная индентация для кода

vim.o.wrap = true

-- Save undo history
vim.opt.undofile = true

vim.g.have_nerd_font = true

local signs = { Error = " ", Warn = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Cursors
-- vim.cmd [[
--   highlight Cursor guifg=#e9dbb7 guibg=#d83e2d
--   highlight CursorInsert guifg=NONE guibg=#d83e2d
--   highlight CursorReplace guifg=NONE guibg=#d3869b
-- ]]
--
-- vim.opt.guicursor = table.concat({
--     "n-v-c:block-Cursor",
--     "i-ci-ve:ver35-CursorInsert",
--     "r-cr:hor20-CursorReplace",
-- }, ",")

vim.opt.termguicolors = true
