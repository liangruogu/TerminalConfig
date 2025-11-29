-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute {
          toggle = true,
          dir = vim.loop.cwd(),
        }
      end,
      desc = 'NeoTree reveal',
      silent = true,
    },
  },
  opts = {
    filesystem = {
      bind_to_cwd = false,
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['l'] = 'open',
          ['q'] = 'close_window',
          ['<C-h>'] = function(state)
            vim.cmd 'wincmd h'
          end,
          ['<C-l>'] = function(state)
            vim.cmd 'wincmd l'
          end,
        },
      },
    },
  },
}
