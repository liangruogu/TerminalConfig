-- ~/.config/nvim/lua/forest/plugins/quarto.lua
return {
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      lspFeatures = {
        languages = { 'r', 'python', 'rust' },
        chunks = 'all',
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        hover = 'K',
        definition = 'gd',
        rename = '<leader>rn',
        references = 'gr',
        format = '<leader>gf',
      },
      codeRunner = {
        enabled = true,
        default_method = 'molten', -- 你现在的设置
      },
    },
    config = function(_, opts)
      -- 先按你写的 opts 初始化
      require('quarto').setup(opts)

      -- 然后再绑 runner 的键
      local runner = require 'quarto.runner'

      vim.keymap.set('n', '<localleader>rc', runner.run_cell, { desc = 'quarto: run cell', silent = true })
      vim.keymap.set('n', '<localleader>ra', runner.run_above, { desc = 'quarto: run cell and above', silent = true })
      vim.keymap.set('n', '<localleader>rA', runner.run_all, { desc = 'quarto: run all cells', silent = true })
      vim.keymap.set('n', '<localleader>rl', runner.run_line, { desc = 'quarto: run line', silent = true })
      vim.keymap.set('v', '<localleader>r', runner.run_range, { desc = 'quarto: run visual range', silent = true })
      vim.keymap.set('n', '<localleader>RA', function()
        runner.run_all(true)
      end, { desc = 'quarto: run all cells (all langs)', silent = true })
    end,
  },
}
