return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-mini/mini.icons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    dashboard.section.header.val = {
      '',
      '',
      '',
      '',
      '',
      '',
      '  ╭─────────────────────────────╮',
      '  │         KEEP SIMPLE         │',
      '  │    create. focus. refine.   │',
      '  ╰─────────────────────────────╯',
      '',
    }

    dashboard.section.buttons.val = {
      dashboard.button('n', '  New file', ':ene <BAR> startinsert<CR>'),
      dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
      dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
      dashboard.button('p', '  Projects', ':Telescope projects<CR>'),
      dashboard.button('d', 'D  Daily', ':Telescope projects<CR>'),
      dashboard.button('c', '  Config', ':cd ~/.config/nvim | Ex<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    -- 也可以加个 footer
    -- dashboard.section.footer.val = 'happy hacking ✨'

    alpha.setup(dashboard.opts)
  end,
}
