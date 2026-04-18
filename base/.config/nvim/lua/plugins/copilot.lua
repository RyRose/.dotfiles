---@type LazySpec
return {
  {
    'zbirenbaum/copilot.lua',
    enabled = vim.g.enable_copilot,
    dependencies = {
      'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
    },
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
    enabled = vim.g.enable_copilot,
  },
}
