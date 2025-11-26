-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is a helper function to make it easier to define actions.
local act = wezterm.action

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "catppuccin-frappe"

config.font = wezterm.font("JetBrains Mono")

config.tab_bar_at_bottom = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Macbook Air - 227 ppi
-- https://support.apple.com/en-us/111933
config.font_size = 12
config.dpi = 227

-- https://wezfurlong.org/wezterm/config/lua/config/window_decorations.html
config.window_decorations = "RESIZE"

config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- create new tab
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- splitting
	{
		mods = "LEADER",
		key = "_",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "|",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- zoom
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- rotate panes
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},

	-- Move between panes with vim keybindings
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},

	-- Resize panes with vim keybindings
	{
		key = "h",
		mods = "CTRL | LEADER",
		-- action = act.AdjustPaneSize({ "Left", 5 }),
		action = act.ActivateKeyTable({
			name = "resize_pane",
			until_unknown = true,
			one_shot = false,
		}),
	},
	{
		key = "j",
		mods = "CTRL | LEADER",
		--  action = act.AdjustPaneSize({ "Down", 5 }),
		action = act.ActivateKeyTable({
			name = "resize_pane",
			until_unknown = true,
			one_shot = false,
		}),
	},
	{
		key = "k",
		mods = "CTRL | LEADER",
		--  action = act.AdjustPaneSize({ "Up", 5 }),
		action = act.ActivateKeyTable({
			name = "resize_pane",
			until_unknown = true,
			one_shot = false,
		}),
	},
	{
		key = "l",
		mods = "CTRL | LEADER",
		-- action = act.AdjustPaneSize({ "Right", 5 }),
		action = act.ActivateKeyTable({
			name = "resize_pane",
			until_unknown = true,
			one_shot = false,
		}),
	},

	-- Enable copy mode with tmux bindings.
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
}

for i = 1, 8 do
	-- LEADER + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,
	-- we made the activation one_shot=false. We therefore need
	-- to define a key assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = "h", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "l", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "k", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "j", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

-- Use retro tab bar since it's more compact.
config.use_fancy_tab_bar = false

-- Disable + in tab bar since LEADER + c creates new tab.
config.show_new_tab_button_in_tab_bar = false

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
-- config.default_gui_startup_args = { "connect", "unix" }

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Catppuccin Frappe",
		tabs_enabled = true,
		color_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		-- tabline_a = { 'mode' },
		tabline_a = {},
		-- tabline_b = { 'workspace' },
		tabline_b = {},
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = {
			"index",
			{ "process", padding = { left = 0, right = 1 } },
		},
		-- tabline_x = { "ram", "cpu" },
		tabline_x = {},
		-- tabline_y = { "datetime", "battery" },
		tabline_y = {},
		-- tabline_z = { "domain" },
		tabline_z = {},
	},
	extensions = {},
})

tabline.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
