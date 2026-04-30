-- Useful plugin to show you pending keybinds.

---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      { '<leader>a', group = 'H[a]rpoon' },
      { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
      { '<leader>d', group = 'Document' },
      { '<leader>r', group = 'Rename' },
      { '<leader>s', group = 'Search' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
