local wezterm = require("wezterm")

local M = {}

local keys = {
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "N",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.SpawnWindow,
	},
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action.ShowDebugOverlay,
	},
	{
		key = "Enter",
		mods = "LEADER",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 30 },
		}),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 40 },
		}),
	},
	{
		key = "P",
		mods = "LEADER",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "]",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
}

wezterm.on("update-right-status", function(window)
	local leader = ""
	if window:leader_is_active() then
		leader = "LEADER"
	end
	window:set_right_status(leader)
end)

function M.apply_to_config(config)
	config.leader = { key = "a", mods = "CTRL" }
	config.keys = keys
end

return M
