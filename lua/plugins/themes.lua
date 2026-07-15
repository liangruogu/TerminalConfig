return {
  -- { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ... },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
