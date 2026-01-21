-- Show vertical lines at 100 characters
-- vim.opt.colorcolumn = '100'

-- Set your limit
local limit = 100

-- Create a namespace for our highlight (avoids clobbering other matches)
local ns = vim.api.nvim_create_namespace 'over_limit'

-- Function to update highlighting
local function highlight_over_limit(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1) -- clear previous highlights

  -- Get all lines in buffer
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i, line in ipairs(lines) do
    if #line > limit then
      -- Highlight only the text past the limit
      vim.api.nvim_buf_add_highlight(bufnr, ns, 'ColorColumn', i - 1, limit, #line)
    end
  end
end

-- Setup autocmds to update highlight on changes
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'TextChanged', 'TextChangedI' }, {
  callback = function(args)
    highlight_over_limit(args.buf)
  end,
})

return {}
