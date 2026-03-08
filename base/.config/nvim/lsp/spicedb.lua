---@brief
---
--- https://authzed.com/blog/launching-2-new-developer-tools-lsp-and-vs-code-extension
---
--- Spicedb language server.
---
--- `spicedb` can be installed by following the instructions
--- [here](https://authzed.com/docs/spicedb/getting-started/discovering-spicedb).
---
--- The default `cmd` assumes that the `spicedb` binary can be found in `$PATH`.
---
---

---@type vim.lsp.Config
return {
  cmd = { 'spicedb', 'lsp' },
  filetypes = { 'authzed' },
  root_markers = {
    '.git',
  },
}
