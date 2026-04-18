vim.filetype.add {
  extension = {
    -- Key is the extension, value is the filetype name
    ['in'] = 'in',
  },
}

---@type LazySpec
return {
  'tpope/vim-abolish',
}
