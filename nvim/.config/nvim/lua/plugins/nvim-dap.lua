-- File: lua/plugins/dap.lua
return {
    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"

            -- Setup UI
            dapui.setup {
                icons = { expanded = "▾", collapsed = "▸" },
                layouts = {
                    {
                        elements = {
                            "scopes",
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = { "repl", "console" },
                        size = 10,
                        position = "bottom",
                    },
                },
                floating = { border = "rounded" },
            }

            -- Open/close UI automatically
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Virtual text for variable values
            require("nvim-dap-virtual-text").setup {
                enabled = true,
                commented = true,
                highlight_changed_variables = true,
                show_stop_reason = true,
            }
        end,
        event = "VeryLazy",
    },

    -- Core DAP
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require "dap"

            -- C, C++, Rust: codelldb
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath "data"
                        .. "/mason/packages/codelldb/extension/adapter/codelldb",
                    args = { "--port", "${port}" },
                },
            }

            local cpp_config = {
                name = "Launch executable",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/main", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = true,
            }

            dap.configurations.cpp = { cpp_config }
            dap.configurations.c = { cpp_config }
            dap.configurations.rust = { cpp_config }

            -- Python: debugpy
            dap.adapters.python = {
                type = "executable",
                command = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python",
                args = { "-m", "debugpy.adapter" },
            }

            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function()
                        local venv = os.getenv "VIRTUAL_ENV"
                        if venv then
                            return venv .. "/bin/python"
                        else
                            return "/usr/bin/python3"
                        end
                    end,
                },
            }

            -- Breakpoint signs
            vim.fn.sign_define(
                "DapBreakpoint",
                { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
            )
            vim.fn.sign_define(
                "DapBreakpointRejected",
                { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
            )
            vim.fn.sign_define("DapStopped", {
                text = "",
                texthl = "DiagnosticSignWarn",
                linehl = "Visual",
                numhl = "DiagnosticSignWarn",
            })

            -- Keymaps
            local map = vim.keymap.set

            -- Основные команды DAP
            map("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "Start or continue debugger" })
            map(
                "n",
                "<leader>db",
                "<cmd>DapToggleBreakpoint<CR>",
                { desc = "Add breakpoint at current line" }
            )
            map("n", "<leader>dx", "<cmd>DapTerminate<CR>", { desc = "Terminate debugger" })
            map("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step over" })
            map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step into" })
            map("n", "<leader>du", "<cmd>DapStepOut<CR>", { desc = "Step out" })
            map("n", "<leader>dl", function()
                vim.cmd("e " .. vim.fn.stdpath "cache" .. "/dap.log")
            end, { desc = "Open DAP log" })

            -- Работа с UI (dap-ui)
            map(
                "n",
                "<leader>duo",
                "<cmd>lua require('dapui').open()<CR>",
                { desc = "Open DAP UI" }
            )
            map(
                "n",
                "<leader>duc",
                "<cmd>lua require('dapui').close()<CR>",
                { desc = "Close DAP UI" }
            )
            map(
                "n",
                "<leader>dre",
                "<cmd>lua require('dapui').eval()<CR>",
                { desc = "Evaluate expression under cursor" }
            )
            map(
                "n",
                "<leader>drw",
                "<cmd>lua require('dapui').widgets.hover()<CR>",
                { desc = "Hover widget" }
            )

            -- Работа со стеком
            map(
                "n",
                "<leader>ds",
                "<cmd>lua require('dap').list_breakpoints()<CR>",
                { desc = "List breakpoints" }
            )
            map(
                "n",
                "<leader>dsc",
                "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                { desc = "Set conditional breakpoint" }
            )
            map(
                "n",
                "<leader>dlp",
                "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
                { desc = "Set log point" }
            )
        end,
        event = "VeryLazy",
    },

    -- Mason DAP installer
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        opts = {
            ensure_installed = { "codelldb", "debugpy" },
            automatic_installation = true,
        },
        event = "VeryLazy",
    },
}
