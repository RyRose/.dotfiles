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
}
