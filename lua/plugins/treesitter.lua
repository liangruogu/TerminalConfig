return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'latex', 'html' },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    textobjects = {
      move = {
        enable = true,
        set_jumps = false, -- you can change this if you want.
        goto_next_start = {
          [']b'] = { query = '@code_cell.inner', desc = 'next code block' },
        },
        goto_previous_start = {
          ['[b'] = { query = '@code_cell.inner', desc = 'previous code block' },
        },
      },
      select = {
        enable = true,
        lookahead = true, -- you can change this if you want
        keymaps = {
          ['ib'] = { query = '@code_cell.inner', desc = 'in block' },
          ['ab'] = { query = '@code_cell.outer', desc = 'around block' },
        },
      },
      swap = { -- Swap only works with code blocks that are under the same
        enable = true,
        swap_next = {
          ['<leader>sbl'] = '@code_cell.outer',
        },
        swap_previous = {
          ['<leader>sbh'] = '@code_cell.outer',
        },
      },
    },
  },
}
