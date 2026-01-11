return {
  {
    'zbirenbaum/copilot.lua',
    enabled = vim.g.enable_copilot,
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        ['yaml.ansible'] = true,
      },
    },
  },
  {
    'giuxtaposition/blink-cmp-copilot',
    enabled = vim.g.enable_blink and vim.g.enable_copilot,
  },
  {
    'zbirenbaum/copilot-cmp',
    enabled = not vim.g.enable_blink and vim.g.enable_copilot,
    opts = {},
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = vim.g.enable_copilot,
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    config = function()
      require('CopilotChat').setup {}
      vim.keymap.set('n', '<leader>cc', function()
        require('CopilotChat').toggle()
      end, { desc = 'Toggle Copilot Chat' })

      vim.keymap.set('n', '<leader>cf', '<CMD>CopilotChatFix<CR>', { desc = 'Copilot Fix' })
    end,
  },
}
