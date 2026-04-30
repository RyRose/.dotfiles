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

---@type LazySpec
return {
  'benomahony/uv.nvim',
  -- Optional filetype to lazy load when you open a python file
  ft = 'python',
  dependencies = {
    -- Optional dependency but recommended one of:
    --   "folke/snacks.nvim"
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    picker_integration = true,
  },
}
