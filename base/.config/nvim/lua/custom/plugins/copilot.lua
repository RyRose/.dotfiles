return {
  {
    'zbirenbaum/copilot.lua',
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
    'zbirenbaum/copilot-cmp',
    opts = {},
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
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
    end,
  },
}
