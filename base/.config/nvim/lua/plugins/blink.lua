local function extendIf(cond, t1, t2)
  if cond then
    return vim.tbl_extend('keep', t1, t2)
  else
    return t1
  end
end

local function insertIf(cond, t1, t2)
  if cond then
    return table.insert(t1, t2)
  else
    return t1
  end
end

return {
  'saghen/blink.cmp',
  enabled = vim.g.enable_blink,
  dependencies = {
    -- optional: provides snippets for the snippet source
    'rafamadriz/friendly-snippets',
    { 'giuxtaposition/blink-cmp-copilot', enabled = vim.g.enable_copilot },
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        -- {
        --   'rafamadriz/friendly-snippets',
        --   config = function()
        --     require('luasnip.loaders.from_vscode').lazy_load()
        --   end,
        -- },
      },
    },
  },

  -- use a release tag to download pre-built binaries
  version = 'v1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = { preset = 'default' },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      -- TODO: Switch to this mechanism if on nightly.
      default = insertIf(vim.g.enable_copilot, { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' }, 'copilot'),

      -- Copilot support.
      providers = extendIf(vim.g.enable_copilot, {
        lazydev = { name = 'lazydev', module = 'lazydev.integrations.blink', score_offset = 100 },
      }, {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          kind = 'Copilot',
          score_offset = 100,
          async = true,
        },
      }),
      -- completion = {
      --   enabled_providers = insertIf(vim.g.enable_copilot, {
      --     'lsp',
      --     'path',
      --     'snippets',
      --     'buffer',
      --     'lazydev',
      --   }, 'copilot'),
      -- },
    },

    snippets = { preset = 'luasnip' },

    completion = {
      ghost_text = {
        enabled = true,
      },
    },

    -- experimental signature help support
    signature = { enabled = true },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.default' },
}
