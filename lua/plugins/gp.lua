return {
  'robitx/gp.nvim',
  config = function()
    local conf = {
      -- 1. 禁用默认提供商
      providers = {
        openai = {
          disable = true,
        },
        deepseek = {
          endpoint = 'https://api.deepseek.com/v1/chat/completions',
          secret = os.getenv 'DEEPSEEK_API_KEY',
        },
      },

      agents = {
        -- {
        --   name = 'deepseek-v4-pro',
        --   provider = 'openai',
        --   model = { model = 'deepseek-chat' },
        --   chat = true,
        --   command = false,
        --   system_prompt = '你是一个精通所有编程语言的资深架构师和幽默的编程助手。',
        -- },
        {
          name = 'deepseek-chat',
          provider = 'openai',
          model = { model = 'deepseek-chat' },
          chat = true,
          command = false,
          system_prompt = '你是一个精通所有编程语言的资深架构师和幽默的编程助手。',
        },
      },

      default_chat_agent = 'deepseek-chat',
      -- default_command_agent = 'deepseek-v4-pro',
    }

    require('gp').setup(conf)

    -- 快捷键：Visual 模式下绑定 <leader>wh
    vim.keymap.set('v', '<leader>wh', ":<C-u>'<,'>GpChatNew<CR>", { silent = true })
  end,
}
