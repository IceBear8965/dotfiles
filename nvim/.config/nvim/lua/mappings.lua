require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<C-w>", "<C-\\><C-n><C-w>k", { desc = "Exit Terminal" })

-- map("n", "<leader>rr", function()
--     require("nvchad.term").runner {
--         id = "runner", -- any unique id you want for the terminal
--         pos = "sp", -- "sp", "vsp", "float"
--         cmd = function()
--             local file = vim.fn.expand "%"
--             local ft_cmds = {
--                 python = "python3 " .. file,
--                 lua = "lua " .. file,
--                 sh = "bash " .. file,
--                 javascript = "node " .. file,
--                 typescript = "ts-node " .. file,
--                 go = "go run " .. file,
--                 c = "clang " .. file .. " -o /tmp/a.out && /tmp/a.out",
--                 cpp = "clang++ " .. file .. " -o /tmp/a.out && /tmp/a.out",
--             }
--
--             return ft_cmds[vim.bo.filetype] or vim.notify("Unsupported filetype: " .. vim.bo.filetype)
--         end,
--     }
-- end, { desc = "Run current buffer with nvchad.term.runner" })

-- Code Runner
vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false, desc = "Run Current Buffer" })
vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false, desc = "Run Current Project" })
vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false, desc = "Close Code Runner" })

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

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
