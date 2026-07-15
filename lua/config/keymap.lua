-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<C-n>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-y>', '<cmd>Cm<CR>')
vim.keymap.set('n', '<C-f>', '<cmd>Telescope zoxide list<CR>')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>x', '<cmd>wq<CR>')
vim.keymap.set('n', 'x', '"_x')

local function toggle_compilation_window()
  local target_name = '*compilation*'

  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match(target_name) then
      vim.api.nvim_win_close(win, false)
      return -- 找到了并关闭，直接结束函数
    end
  end

  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    -- 确保 buffer 是有效的并且名字匹配
    if vim.api.nvim_buf_is_valid(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if name:match(target_name) then
        -- 找到了 buffer，在下方水平分屏打开
        vim.cmd('botright sbuf ' .. buf)
        return
      end
    end
  end

  print('未在 :buffers 中找到 ' .. target_name)
end
vim.keymap.set('n', '<C-`>', toggle_compilation_window, { desc = 'Toggle Compilation Window' })

-- delete completely
vim.keymap.set('n', '<localleader>dd', '"_dd')
vim.keymap.set('v', '<localleader>dd', '"_d')
vim.keymap.set('n', '<localleader>d$', '"_d$')
vim.keymap.set('n', '<localleader>dw', '"_dw')
vim.keymap.set('n', '<localleader>diw', '"_diw')
vim.keymap.set('n', '<localleader>daw', '"_daw')
vim.keymap.set('v', '<localleader>dw', '"_dw')
vim.keymap.set('n', '<localleader>dl', '"_dd')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

vim.keymap.set('n', '<C-S-e>', ':Dired /home/chul/', { noremap = true })
vim.keymap.set('n', '<C-e>', function()
  local current_file_dir = vim.fn.expand '%:p:h'
  vim.cmd('Dired ' .. current_file_dir)
end, { noremap = true, desc = "Open Dired in current file's directory" })
