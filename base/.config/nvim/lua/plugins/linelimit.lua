-- Set your line limit
local line_limit = 80

local function is_source_file()
  local bt = vim.bo.buftype -- buffer type
  local ft = vim.bo.filetype -- filetype
  return bt == '' and ft ~= ''
end

-- Function to toggle colorcolumn
local function conditional_colorcolumn()
  if not is_source_file() then
    return
  end

  -- Get the range of visible lines (0-indexed)
  local topline = vim.fn.line 'w0' - 1 -- first visible line
  local botline = vim.fn.line 'w$' - 1 -- last visible line

  -- Get the lines in the visible range
  local lines = vim.api.nvim_buf_get_lines(0, topline, botline + 1, false)

  local exceeds = false
  for _, line in ipairs(lines) do
    local line_length = #line
    exceeds = exceeds or (line_length > line_limit)
    if exceeds then
      break
    end
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
local source_augroup = vim.api.nvim_create_augroup('linelimit', {
  clear = true,
})
vim.api.nvim_create_autocmd(events, {
  group = source_augroup,
  pattern = '*',
  callback = conditional_colorcolumn,
})

return {}
