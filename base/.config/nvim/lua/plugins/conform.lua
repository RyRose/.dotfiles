-- Autoformat on save using Conform, which supports a wide variety of formatters and linters.
--
-- https://github.com/stevearc/conform.nvim#formatters

---@type MasonToolEntry[]
local mason_tools = {
  'black',
  'clang-format',
  'goimports',
  'isort',
  'markdownlint',
  'mdformat',
  {
    'nixfmt',
    condition = function()
      return vim.fn.executable 'nix' == 1
    end,
  },
  'prettier',
  'prettierd',
  'shellcheck',
  'shfmt',
  'sqlfluff',
  'stylua',
  'taplo',
  'templ',
  'yamlfmt',
  'ktlint',
}

---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  init = function()
    vim.list_extend(vim.g.mason_tools, mason_tools)
  end,
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable formatting for certain filetypes altogether.
      local disable_filetypes = { ['in'] = true }
      return {
        timeout_ms = 2000,
        dry_run = disable_filetypes[vim.bo[bufnr].filetype],
        lsp_format = 'fallback',
      }
    end,
    formatters = {
      mdformat = {
        prepend_args = { '--wrap', '80' },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      go = { 'goimports' },

      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      cpp = { 'clang-format' },
      sh = { 'shellcheck', 'shfmt' },
      zsh = { 'shellcheck', 'shfmt' },
      bash = { 'shellcheck', 'shfmt' },
      toml = { 'taplo' },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      htmlangular = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'yamlfmt' },
      markdown = { 'mdformat', 'markdownlint' },
      templ = { 'templ' },
      sql = { 'sqlfluff' },
      nix = { 'nixfmt' },
      kotlin = { 'ktlint' },
      just = { 'just' },
      zig = { 'zigfmt' },
      ['*'] = { 'trim_whitespace' },
    },
  },
}
