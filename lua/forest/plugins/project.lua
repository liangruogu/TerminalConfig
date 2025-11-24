return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      detection_methods = { 'pattern', 'lsp' },
      patterns = { '.git', 'Makefile', 'package.json' },
      on_project_selected = function(path)
        vim.cmd('cd' .. path)
        vim.cmd 'Ex'
      end,
    }
  end,
}
