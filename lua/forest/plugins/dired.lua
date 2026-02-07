return {
  -- 其他插件...

  {
    'X3eRo0/dired.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- 可选，用于显示图标
    config = function()
      require('dired').setup {
        path_separator = '/',
        show_banner = false, -- 类似 Emacs dired，隐藏顶部的提示信息
      }
    end,
  },
}
