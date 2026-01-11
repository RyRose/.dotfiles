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
vim.g.enable_blink = false

-- List of git repositories to enable LSP modified on save.
-- Defaults to no repositories.
vim.b.format_lsp_modified_on_save_repos = nil
