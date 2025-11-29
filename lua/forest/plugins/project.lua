return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      manual_mode = true,

      detection_methods = { 'pattern', 'lsp' },
      patterns = { '.git', 'Makefile', 'package.json' },

      -- 其它选项用默认即可
      -- silent_chdir = true,  -- 在 manual_mode 下其实无所谓
      -- scope_chdir = 'global',
    }
  end,
}
