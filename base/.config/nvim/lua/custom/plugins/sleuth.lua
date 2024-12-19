return {
  {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    config = function()
      -- Trigger after sleuth autocommands.
      -- https://github.com/tpope/vim-sleuth/blob/master/plugin/sleuth.vim#L665
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        desc = 'Update listchars to reflect vim-sleuth autodetection.',
        callback = function()
          if vim.o.expandtab then
            vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
          else
            vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
          end
        end,
      })
    end,
  },
}
