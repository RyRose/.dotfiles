return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
  },
  keys = {
    { '<leader>to', '<CMD>Oil<CR>', desc = 'Toggle [O]il', silent = true },
    { '-', '<CMD>Oil<CR>', desc = 'Toggle [O]il', silent = true },
  },
  dependencies = {
    { 'echasnovski/mini.icons', opts = {} },
  },
}
