-- Configuration for openFGA lsp and Treesitter grammar.

return {
  'RyRose/fga.nvim',
  dependencies = {
    'neovim/nvim-lspconfig', -- Optional, for LSP integration
    'nvim-treesitter/nvim-treesitter', -- Optional, for enhanced syntax highlighting
  },
  opts = {
    install_treesitter_grammar = true,
    lsp_server = 'openfga-lsp',
  },
}
