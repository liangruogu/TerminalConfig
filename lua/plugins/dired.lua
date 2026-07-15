return {
  'X3eRo0/dired.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    -- 正常初始化插件
    require('dired').setup {
      path_separator = '/',
      show_banner = false,
    }
  end,
}
