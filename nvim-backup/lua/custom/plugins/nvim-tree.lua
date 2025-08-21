-- NvimTree is a Neovim plugin to project files
-- https://github.com/nvim-tree/nvim-tree.lua

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      renderer = {
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
          git_placement = 'before',
          modified_placement = 'after',
          hidden_placement = 'after',
          diagnostics_placement = 'signcolumn',
          bookmarks_placement = 'signcolumn',
          padding = ' ',
          symlink_arrow = ' ➛ ',
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            hidden = false,
            diagnostics = true,
            bookmarks = true,
          },
          glyphs = {
            default = '',
            symlink = '',
            bookmark = '󰆤',
            modified = '●',
            hidden = '󰜌',
            folder = {
              arrow_closed = '',
              arrow_open = '',
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
              symlink_open = '',
            },
            git = {
              unstaged = '✗',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '★',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },
      view = {
        width = 30,
      },
    }
  end,
}
