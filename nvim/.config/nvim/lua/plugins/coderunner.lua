require("code_runner").setup({
    term = {
        --  Position to open the terminal, this option is ignored if mode ~= term
        position = "bot",
        -- window size, this option is ignored if mode == tab
        size = 12,
    },
    float = {
        close_key = "<ESC>",
        -- Window border (see ':h nvim_open_win')
        border = "none",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        -- Transparency (see ':h winblend')
        blend = 0,
    },
    filetype = {
        python = "python3 -u",
    },
    project = {
        ["~/projects/TsumCopyrightTool"] = {
            name = "TsumCopyrightTool",
            description = "Tool for copyright",
            file_name = "TsumCopyrightTool.py",
        },
        ["~/projects/weather-app/"] = {
            name = "weather-app",
            description = "Weather app with react",
            file_name = "npm run dev",
        },
    },
})
