-- Treat .env files as dotenv, but keep sh syntax highlighting
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.env',
  callback = function()
    vim.bo.filetype = 'dotenv' -- set filetype to dotenv
    vim.cmd 'setlocal syntax=sh' -- keep shell syntax highlighting
  end,
})

return {
  'tpope/vim-dotenv',
}
