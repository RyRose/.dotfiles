-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Initialize mason_tools to append to across all plugins.
vim.g.mason_tools = {}

-- Enable copilot by default.
vim.g.enable_copilot = true

-- Enable blink instead of nvim-cmp.
vim.g.enable_blink = false

-- Arbitrary lua code to run before Lazy is loaded.
pcall(require, 'custom.before')

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
require('lazy').setup({
  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },

  {
    -- Ensure all mason tools are installed that are stored across plugins.
    -- This must follow all plugins.
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      local tools = {}

      for _, value in ipairs(vim.g.mason_tools) do
        if type(value) == 'table' and #value == 2 then
          found = false
          for _, alt in ipairs(value[2]) do
            if vim.fn.executable(alt) == 1 then
              found = true
            end
          end
          if not found then
            table.insert(tools, value[1])
          end
        elseif type(value) == 'string' then
          if vim.fn.executable(value) ~= 1 then
            table.insert(tools, value)
          end
        end
      end

      require('mason-tool-installer').setup {
        ensure_installed = tools,
      }
    end,
  },
}, {
  git = {
    throttle = {
      -- Enable throttling if errors are encountered.
      -- enabled = true,
    },
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
