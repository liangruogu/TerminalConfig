-- [[ Basic Autocommands ]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = { '*.png', '*.jpg', '*.jpeg', '*.ico', '*.webp', '*.gif', '*.pdf' },
  callback = function()
    local file = vim.fn.expand '%:p'
    local opener = 'xdg-open'
    vim.fn.jobstart({ opener, file }, { detach = true })
    vim.api.nvim_buf_delete(0, { force = true })
    pcall(function()
      vim.cmd 'Dired'
    end)
  end,
})

vim.api.nvim_create_user_command('EditConf', function()
  vim.cmd 'cd ~/.config/nvim/ | edit init.lua'
end, {})

vim.api.nvim_create_user_command('Sway', function()
  vim.fn.jobstart 'swayimg --gallery'
end, {})

vim.api.nvim_create_user_command('Bfs', 'buffers', {})

vim.api.nvim_create_user_command('Cm', function()
  local ext = vim.fn.expand '%:e'
  local filename = vim.fn.expand '%:t'
  local filename_no_ext = vim.fn.expand '%:t:r'

  local cmd
  if ext == 'py' then
    cmd = 'uv run ' .. filename
  elseif ext == 'rs' then
    cmd = 'cargo run --bin ' .. filename_no_ext
  elseif ext == 'cpp' or ext == 'c' or ext == 'cc' then
    cmd = 'g++ ' .. filename .. ' -o ' .. filename_no_ext .. ' && ./' .. filename_no_ext
  elseif ext == 'zig' then
    cmd = 'zig run' .. filename
  end

  if cmd ~= '' then
    vim.cmd('Compile ' .. cmd)
  else
    print('No compile command for .' .. ext .. ' files')
  end
end, {})
