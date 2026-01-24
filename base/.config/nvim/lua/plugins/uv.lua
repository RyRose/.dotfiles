-- Detect uv run scripts as Python
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*',
  callback = function()
    local first_line = vim.fn.getline(1)
    if first_line:match '^#!.*uv run' then
      vim.bo.filetype = 'python'
    end
  end,
})

return {}
