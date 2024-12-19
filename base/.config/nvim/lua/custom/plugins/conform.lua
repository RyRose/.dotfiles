return {
  { -- Autoformat
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
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      vim.g.mason_tools = vim.list_extend(vim.g.mason_tools, {
        'black',
        'goimports',
        'markdownlint',
        'mdformat',
        'prettier',
        'prettierd',
        'shellcheck',
        'shfmt',
        'sqlfluff',
        'stylua',
        'taplo',
        'templ',
        'yamlfmt',
      })
    end,
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 2000,
          lsp_format = lsp_format_opt,
          dry_run = vim.g.format_lsp_modified_on_save(),
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
        -- sql = { 'sql-formatter' },
        ['_'] = { 'trim_whitespace' },
      },
    },
  },
}
