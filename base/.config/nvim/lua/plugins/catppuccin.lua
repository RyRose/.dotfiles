return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    require('catppuccin').setup {
      integrations = {
        gitsigns = true,
        fidget = true,
        neotree = true,
        cmp = true,
        render_markdown = true,
        telescope = {
          enabled = true,
        },
        which_key = true,
      },
    }
    -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}
