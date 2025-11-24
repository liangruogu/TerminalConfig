return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 15,
      open_mapping = [[<c-`>]], -- 你原来的
      direction = 'horizontal',
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      persist_mode = true,
    }

    -- 小工具函数：在普通模式和终端模式都能用
    local function map_toggleterm_key(lhs, term_id)
      -- normal 模式
      vim.keymap.set('n', lhs, function()
        vim.cmd(tostring(term_id) .. 'ToggleTerm direction=horizontal')
      end, { noremap = true, silent = true })

      -- terminal 模式（先退出终端模式再执行）
      vim.keymap.set('t', lhs, function()
        local esc = vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'n', false)
        vim.cmd(tostring(term_id) .. 'ToggleTerm direction=horizontal')
      end, { noremap = true, silent = true })
    end

    -- 这里映射 1/2/3 号终端
    map_toggleterm_key('<C-1>', 1)
    map_toggleterm_key('<C-2>', 2)
    map_toggleterm_key('<C-3>', 3)
  end,
}
