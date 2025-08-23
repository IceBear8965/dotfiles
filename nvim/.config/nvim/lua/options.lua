require "nvchad.options"

-- add yours here!

local o = vim.o

o.relativenumber = true
o.confirm = true

-- Tab width
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.wrap = true

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

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
