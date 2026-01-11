-- Load settings (vim options, keymaps, autocommands, etc)
-- NOTE: Must be done before loading plugins.
require 'custom.settings'

-- Arbitrary lua code to run before Lazy is loaded if it exists.
-- Should follow settings to allow overriding settings before plugins load.
-- Intended for use per-environment.
pcall(require, 'custom.before')

-- Load Lazy and all plugins
require 'custom.lazy'
