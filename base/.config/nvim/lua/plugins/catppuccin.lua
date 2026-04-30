---@type LazySpec
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    require('catppuccin').setup {
      integrations = {
        blink_cmp = true,
        fidget = true,
        gitsigns = true,
        neotree = true,
        render_markdown = true,
        telescope = true,
        which_key = true,
      },
    }
    -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}
