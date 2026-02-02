-- Set your line limit
local line_limit = 80

-- Function to toggle colorcolumn
local function conditional_colorcolumn()
  -- Get the range of visible lines (0-indexed)
  local topline = vim.fn.line 'w0' - 1 -- first visible line
  local botline = vim.fn.line 'w$' - 1 -- last visible line

  -- Get the lines in the visible range
  local lines = vim.api.nvim_buf_get_lines(0, topline, botline + 1, false)

  local exceeds = false
  for _, line in ipairs(lines) do
    local line_length = #line
    exceeds = exceeds or (line_length > line_limit)
  end
  if exceeds then
    vim.opt_local.colorcolumn = tostring(line_limit)
  else
    vim.opt_local.colorcolumn = ''
  end
end

-- Autocmds to update on text changes
local events = {
  'InsertLeave',
  'TextChanged',
  'TextChangedI',
  'BufEnter',
  'WinScrolled',
}
vim.api.nvim_create_autocmd(events, {
  pattern = '*',
  callback = conditional_colorcolumn,
})

return {}
