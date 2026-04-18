-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
--
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Load settings (vim options, keymaps, autocommands, etc)
-- along with optional override.
-- NOTE: Must be done before loading plugins.

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
-- Uncomment to use ollama proxy for offline copilot.
-- vim.g.copilot_proxy = 'http://localhost:11435'
-- vim.g.copilot_proxy_strict_ssl = false

-- Enable blink instead of nvim-cmp.
vim.g.enable_blink = true

-- List of git repositories to enable LSP modified on save.
-- Defaults to no repositories.
vim.b.format_lsp_modified_on_save_repos = nil

pcall(require, 'config.override')

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
require('lazy').setup 'plugins'
