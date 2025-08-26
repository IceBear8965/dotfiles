local map = vim.keymap.set

map("t", "<C-w>", "<C-\\><C-n><C-w>k", { desc = "Exit Terminal" })

-- Удобное переключение между буфферами
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- ======================================
-- 🔹 Управление сплитами
-- ======================================

-- Создание сплитов
map("n", "<leader>sh", "<C-w>s", { desc = "Horizontal split" })
map("n", "<leader>sv", "<C-w>v", { desc = "Vertical split" })

-- Закрытие и балансировка
map("n", "<leader>sc", "<C-w>c", { desc = "Close current split" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })

-- Изменение размеров сплитов
map("n", "<C-S-h>", ":vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-S-l>", ":vertical resize +2<CR>", { desc = "Increase width" })
map("n", "<C-S-j>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<C-S-k>", ":resize -2<CR>", { desc = "Decrease height" })

-- Перемещение сплитов
map("n", "<leader>sH", "<C-w>H", { desc = "Move split far left" })
map("n", "<leader>sL", "<C-w>L", { desc = "Move split far right" })
map("n", "<leader>sJ", "<C-w>J", { desc = "Move split far down" })
map("n", "<leader>sK", "<C-w>K", { desc = "Move split far up" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

map("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics under cursor" })

-- Nvim Tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- Закрытие текущего буфера
map("n", "<leader>x", ":BufferLineClose<CR>", { desc = "Close buffer" })

-- Code Runner
map(
    "n",
    "<leader>rr",
    ":RunCode<CR>",
    { noremap = true, silent = false, desc = "Run Current Buffer" }
)
map(
    "n",
    "<leader>rp",
    ":RunProject<CR>",
    { noremap = true, silent = false, desc = "Run Current Project" }
)
map(
    "n",
    "<leader>rc",
    ":RunClose<CR>",
    { noremap = true, silent = false, desc = "Close Code Runner" }
)

-- Debugger
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Add breakpoint at current line" })
map("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "Start or continue debugger" })
map("n", "<leader>dx", "<cmd>DapTerminate<CR>", { desc = "Terminate debugger" })
map("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step over" })
map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step into" })
map("n", "<leader>du", "<cmd>DapStepOut<CR>", { desc = "Step out" })
map("n", "<leader>dl", function()
    vim.cmd("e " .. vim.fn.stdpath "cache" .. "/dap.log")
end, { desc = "Open DAP log" })
