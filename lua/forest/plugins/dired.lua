-- return {
--   'X3eRo0/dired.nvim',
--   dependencies = { 'nvim-tree/nvim-web-devicons' }, -- 可选，用于显示图标
--   config = function()
--     require('dired').setup {
--       path_separator = '/',
--       show_banner = false, -- 类似 Emacs dired，隐藏顶部的提示信息
--     }
--   end,
-- }
--
--
return {
  'X3eRo0/dired.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    -- 正常初始化插件
    require('dired').setup {
      path_separator = '/',
      show_banner = false,
    }

    -- 创建自定义用户指令 :Lc <文件名>
    vim.api.nvim_create_user_command('Lc', function(opts)
      -- 1. 自动获取目标目录
      local current_dir = nil

      -- 如果当前是在 dired 界面，直接从当前缓冲区的变量 b:dired_current_path 中抓取绝对路径
      if vim.bo.filetype == 'dired' then
        current_dir = vim.b.dired_current_path
      end

      -- 如果不在 dired 界面，或者没抓到，则退回到当前工作目录
      if not current_dir or current_dir == '' then
        current_dir = vim.fn.getcwd()
      end

      -- 2. 获取文件名参数
      local filename = opts.args
      if not filename or filename == '' then
        vim.notify('请提供文件名，例如: :Lc two_sum.cpp', vim.log.levels.WARN)
        return
      end

      -- 3. 提取后缀与纯文件名
      local full_path = current_dir .. '/' .. filename
      local ext = filename:match '^.+(%..+)$'
      local name_without_ext = filename:gsub('%..+$', '')
      -- 清理非法字符作为 C++/Python 的函数名
      local func_name = name_without_ext:gsub('[^%w_]', '_')

      -- 4. 创建并打开文件
      vim.cmd('edit ' .. vim.fn.fnameescape(full_path))

      -- 5. 准备模板
      local lines = {}
      if ext == '.cpp' then
        lines = {
          '#include <iostream>',
          '#include <vector>',
          'using namespace std;',
          '',
          'struct TreeNode {',
          '    int val;',
          '    TreeNode* left;',
          '    TreeNode* right;',
          '    TreeNode(): val(0), left(nullptr), right(nullptr) {}',
          '    TreeNode(int x): val(x), left(nullptr), right(nullptr) {}',
          '    TreeNode(int x, TreeNode* left, TreeNode* right): val(x), left(left), right(right) {}',
          '};',
          '',
          'class Solution {',
          'public:',
          '    TreeNode* ' .. func_name .. '(TreeNode* root) {',
          '        // TODO: 在这里编写算法逻辑',
          '        return root;',
          '    }',
          '};',
          '',
          'int main() {',
          '    Solution solution;',
          '    // TODO: 构建测试用例并调用 solution.' .. func_name .. '(root);',
          '    return 0;',
          '}',
        }
      elseif ext == '.py' then
        lines = {
          'from typing import List, Optional',
          '',
          'def ' .. func_name .. '():',
          '    pass',
          '',
          'if __name__ == "__main__":',
          '    ' .. func_name .. '()',
        }
      end

      -- 6. 写入文件并对齐光标
      if #lines > 0 then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        vim.cmd 'write'
        if ext == '.cpp' then
          vim.api.nvim_win_set_cursor(0, { 7, 4 })
        elseif ext == '.py' then
          vim.api.nvim_win_set_cursor(0, { 4, 4 })
        end
      end
    end, {
      nargs = 1,
      complete = 'file',
      desc = 'Create a LeetCode solution file with template',
    })
  end,
}
