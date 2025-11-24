-- return {
--   { -- Add indentation guides even on blank lines
--     'lukas-reineke/indent-blankline.nvim',
--     -- Enable `lukas-reineke/indent-blankline.nvim`
--     -- See `:help ibl`
--     main = 'ibl',
--     opts = {},
--   },
-- }
--
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '┆', -- 竖线字符，可改成 ▏ ┆ ┊
        tab_char = '│', -- tab 缩进也用竖线
      },
      whitespace = {
        remove_blankline_trail = true, -- 不显示空行结尾的线
      },
      scope = {
        enabled = false, -- 🚫 禁用上下文线（会导致横线）
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
    end,
  },
}
