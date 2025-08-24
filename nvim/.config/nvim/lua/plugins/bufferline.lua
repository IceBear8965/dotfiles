return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                style_preset = bufferline.style_preset.no_italic,
                separator_style = "slope",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "center",
                    },
                },
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = {'close'}
                },
                show_close_icon = true,
                show_buffer_close_icons = true,
                always_show_bufferline = true,
            },
        })

        local map = vim.keymap.set
        -- Закрыть текущий буфер через Lua API
        map("n", "<leader>x", function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            local curr = vim.api.nvim_get_current_buf()
            local next_buf = nil

            if #bufs > 1 then
                -- находим следующий буфер
                for i, buf in ipairs(bufs) do
                    if buf.bufnr == curr then
                        if i < #bufs then
                            next_buf = bufs[i + 1].bufnr
                        else
                            next_buf = bufs[1].bufnr
                        end
                        break
                    end
                end
            end

            -- закрываем текущий буфер
            vim.api.nvim_buf_delete(curr, { force = false })

            -- переключаемся на следующий, если он есть
            if next_buf and vim.api.nvim_buf_is_valid(next_buf) then
                vim.api.nvim_set_current_buf(next_buf)
            else
                -- если больше буферов нет, открываем пустой
                vim.cmd("enew")
            end
        end, { desc = "Close current buffer and switch to next", noremap = true, silent = true })


        map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
        map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    end,
}
