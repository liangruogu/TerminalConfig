return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 15,
      open_mapping = [[<c-\>]],
      direction = 'float',
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      persist_mode = true,
    }

    local function map_toggleterm_key(lhs, term_id)
      vim.keymap.set('n', lhs, function()
        vim.cmd(tostring(term_id) .. 'ToggleTerm direction=horizontal')
      end, { noremap = true, silent = true })

      vim.keymap.set('t', lhs, function()
        local esc = vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'n', false)
        vim.cmd(tostring(term_id) .. 'ToggleTerm direction=horizontal')
      end, { noremap = true, silent = true })
    end

    map_toggleterm_key('<C-1>', 1)
    map_toggleterm_key('<C-2>', 2)
    map_toggleterm_key('<C-3>', 3)
  end,
}
