-- LSP Types

---@class NixFlake
---@field autoArchive boolean|nil
---@field autoEvalInputs boolean
---@field nixpkgsInputName string|nil

---@class NixSettings
---@field binary string
---@field maxMemoryMB number|nil
---@field flake NixFlake

---@class NilConfig
---@field formatting { command: string[]|nil }
---@field diagnostics { ignored: string[], excludedFiles: string[] }
---@field nix NixSettings

---@class Config
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
---@field lsp vim.lsp.Config?
--- Override the default Mason tool for this server.
--- Useful when the Mason package name doesn't match the LSP server name.
---@field mason_tool MasonToolEntry?
--- Set to true to disable Mason installation for this server.
--- Defaults to false.
---@field disableMason boolean?

---@type table<string, Config>
local servers = {
  clangd = {},
  bzl = {},
  yamlls = {},
  taplo = {},
  gopls = {},
  pyright = {},
  html = {},
  angularls = {},
  templ = {},
  htmx = {},
  tailwindcss = {},
  ansiblels = {},
  zls = {},
  nil_ls = {
    lsp = {
      settings = {
        ---@type NilConfig
        ['nil'] = {
          formatting = {},
          diagnostics = {},
          nix = {
            binary = 'nix',
            flake = {
              autoArchive = true,
              autoEvalInputs = false,
            },
          },
        },
      },
    },
  },
  lua_ls = {
    mason_tool = 'lua-lsp',
    lsp = {
      -- cmd = {...},
      -- filetypes = { ...},
      -- capabilities = {},
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              '${3rd}/busted/library',
              '${3rd}/luassert/library',
            },
          },

          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
  },
  spicedb = {
    mason_tool = {
      condition = function()
        return false
      end,
    },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    end

    -- Find references for the word under your cursor.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_references) then
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    end

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_implementation) then
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    end

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_typeDefinition) then
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    end

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentSymbol) then
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    end

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    if client and client:supports_method(vim.lsp.protocol.Methods.workspace_symbol) then
      map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    end

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_rename) then
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    end

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeAction) then
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    end

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_declaration) then
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

---@type LazySpec
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {},
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Useful status updates for LSP.
      {
        'j-hui/fidget.nvim',
        opts = {
          -- https://github.com/catppuccin/nvim/tree/main
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
      -- Allows extra capabilities provided by blink
      'saghen/blink.cmp',
    },

    config = function()
      for name, server in pairs(servers) do
        vim.list_extend(vim.g.mason_tools, { server.mason_tool or name })
        server.lsp = server.lsp or {}
        server.lsp.capabilities = require('blink.cmp').get_lsp_capabilities(server.lsp.capabilities, true)
        vim.lsp.config(name, server.lsp)
        vim.lsp.enable(name)
      end
    end,
  },
}
