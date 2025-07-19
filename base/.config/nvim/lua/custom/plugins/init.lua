vim.g.format_lsp_modified_on_save = function()
  if vim.g.format_lsp_modified_on_save_repos == nil then
    return false
  end
  if vim.b.format_lsp_modified_on_save ~= nil then
    return vim.b.format_lsp_modified_on_save
  end
  local root_path = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true, cwd = vim.fn.expand '%:p:h' }):wait().stdout

  -- Default to not formatting lsp modified on save.
  -- This should only occur if we are not in a git repo, in which
  -- case it is unsupported anyways.
  if not root_path then
    vim.b.format_lsp_modified_on_save = false
    return vim.b.format_lsp_modified_on_save
  end
  local parts = vim.split(root_path, '/')
  local git_repo_name = vim.trim(parts[#parts])
  vim.b.format_lsp_modified_on_save = vim.g.format_lsp_modified_on_save_repos[git_repo_name] ~= nil
  return vim.b.format_lsp_modified_on_save
end

return {
  'tpope/vim-abolish',
}
