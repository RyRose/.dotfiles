-- Ensure that third-party servers and tools are installed using Mason.
--
-- To check the current status of installed tools and/or manually install
-- other tools, you can run
--   :Mason
--
-- You can press `g?` for help in this menu.

---@type LazySpec
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  -- Make sure plugin is loaded very late to ensure
  -- all mason tools from other plugins are already added to
  -- vim.g.mason_tools.
  event = 'VeryLazy',
  config = function()
    require('mason').setup()
    require('mason-tool-installer').setup {
      ensure_installed = vim.g.mason_tools,
    }
  end,
}
