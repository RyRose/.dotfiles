return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  -- Make sure plugin is loaded very late to ensure
  -- all mason tools from other plugins are already added to
  -- vim.g.mason_tools.
  event = 'VeryLazy',
  config = function()
    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require('mason').setup()

    local tools = {}
    for _, value in ipairs(vim.g.mason_tools) do
      if type(value) == 'table' and #value == 2 then
        local found = false
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
}
