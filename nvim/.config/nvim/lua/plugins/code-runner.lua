return {
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
        require("code_runner").setup {
            filetype = {
                python = "python3 -u",
                cpp = "clang++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
                c = "clang $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
                javascript = "node",
                typescript = "ts-node",
                rust = "cargo run",
                go = "go run",
                sh = "bash",
            },
            project = {
                ["~/Repositories/TsumCopyrightTool"] = {
                    name = "TsumCopyrightTool",
                    description = "Util for copyrighting",
                    command = "python3 TsumCopyrightTool.py",
                },
            },
        }
    end,
}
