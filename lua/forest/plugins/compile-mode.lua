return {
  'ej-shafran/compile-mode.nvim',
  version = '^5.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = {
      -- 将 default_command 设置为一个函数
      default_command = function()
        local ext = vim.fn.expand '%:e'
        local filename = vim.fn.expand '%:t'
        local filename_no_ext = vim.fn.expand '%:t:r'

        if ext == 'py' then
          return 'uv run ' .. filename
        elseif ext == 'rs' then
          return 'cargo run --bin ' .. filename_no_ext
        else
          return 'make'
        end
      end,
    }
  end,
}
