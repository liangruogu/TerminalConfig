return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'jvgrootveld/telescope-zoxide' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        -- mappings = {
        --   i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        -- },
        borderchars = {
          prompt = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        },
        file_ignore_patterns = {
          'node_modules',
          '%.pyc',
          '%.png',
          '%.jpg',
          '%.mp4',
          '%.git/',
          '%.pth',
          '%.safetensors',
          'LICENSE',
          'target',
          '%.lock',
          '%.npz',
          '%.pkl',
        },
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        zoxide = {
          prompt_title = '[ Zoixde Jump ]',
          mappings = {
            default = {
              after_action = function(selection)
                print('Directory switched to: ' .. selection.path)
              end,
            },
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'zoxide')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [T]elescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>sp', ':Telescope projects<CR>', { desc = '[S]earch [P]rojects' })
    vim.keymap.set('n', '<leader>fs', function()
      builtin.lsp_document_symbols {
        symbols = { 'Function', 'Method', 'Variable' },
      }
    end, { desc = '[F]ind [S]ymbols in current file' })
    vim.keymap.set('n', '<leader>ss', function()
      builtin.lsp_dynamic_workspace_symbols {
        symbols = { 'Function', 'Method', 'Variable' },
      }
    end, { desc = '[S]earch [S]mbols in current project' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
