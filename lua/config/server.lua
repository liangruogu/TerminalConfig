local function find_rsync_cfg(max_levels)
  local dir = vim.fn.getcwd()

  for _ = 1, max_levels do
    local cfg = dir .. '/.rsync.cfg'
    if vim.fn.filereadable(cfg) == 1 then
      return cfg
    end
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then
      break
    end
    dir = parent
  end
  return nil
end
vim.keymap.set('n', '<leader>ra', function()
  local cwd = vim.fn.getcwd()
  local cfg_path = find_rsync_cfg(5)

  if not cfg_path then
    vim.notify('.rsync.cfg not found! \nrunning rsi to create one...', vim.log.levels.ERROR)
    return
  else
    vim.notify('Syncing project via rsync...', vim.log.levels.INFO)
    vim.cmd 'TermExec cmd="psync" go_back=0'
    vim.cmd 'startinsert'
  end
end, { noremap = true, silent = true, desc = '[R]sync [A]ll' })
