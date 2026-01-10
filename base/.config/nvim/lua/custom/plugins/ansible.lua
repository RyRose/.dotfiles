vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    -- Common Ansible file patterns
    '*.ansible.yaml',
    '*.ansible.yml',
    '*/roles/*/tasks/*.yml',
    '*/roles/*/defaults/*.yml',
  },
  callback = function()
    vim.bo.filetype = 'yaml.ansible'
  end,
})

vim.keymap.set('n', '<leader>ta', function()
  vim.bo.filetype = 'yaml.ansible'
end, { desc = 'Toggle [A]nsible filetype' })

return {}
