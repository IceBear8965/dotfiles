-- Bufferline is a Neovim plugin to manage tabs and buffers
-- https://github.com/akinsho/bufferline.nvim?tab=readme-ov-file

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
          },
        },
      },
    }
  end,
}
