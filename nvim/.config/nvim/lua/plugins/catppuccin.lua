return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    integrations = {
      treesitter = true,
      telescope = true,
      mason = true,
      cmp = true,
      gitsigns = true,
      nvimtree = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
