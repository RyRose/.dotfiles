-- Set <space> as the leader key
-- See `:help mapleader`
---@type string
vim.g.mapleader = ' '

-- Set <space> as the local leader key
-- See `:help maplocalleader`
---@type string
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
---@type boolean
vim.g.have_nerd_font = true

--- List of tools to be installed by Mason.
--- You can add to this list from any plugin that needs Mason to install tools.
---@type MasonToolEntry[]
vim.g.mason_tools = {}

-- Whether to enable copilot .
---@type boolean
vim.g.enable_copilot = true

-- Uncomment to use ollama proxy for offline copilot.
-- vim.g.copilot_proxy = 'http://localhost:11435'
-- vim.g.copilot_proxy_strict_ssl = false
