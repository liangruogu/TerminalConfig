return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html', -- if you have `nvim-treesitter` installed
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    cn = {
      enabled = true, ---@type boolean
      translator = true, ---@type boolean
      translate_problems = true, ---@type boolean
    },
  },
}
