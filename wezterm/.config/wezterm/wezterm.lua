local wezterm = require("wezterm")
wezterm.log_info("The config was reloaded!")

local config = {
	-- webgpu_power_preference = "LowPower",
	color_scheme = "Catppuccin Mocha",
	set_environment_variables = {
		TERM = "xterm-256color",
	},

	font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font", "SF Pro" }),
	font_size = 18,
	window_background_opacity = 0.6,
	macos_window_background_blur = 60,
	window_decorations = "RESIZE",

	initial_cols = 80,
	initial_rows = 40,
	window_padding = {
		left = 10,
		right = 0,
		top = 10,
		bottom = 0,
	},

	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
}

require("keymaps").apply_to_config(config)

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "CTRL|SHIFT",
	},
})

return config
