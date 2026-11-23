local wezterm = require("wezterm") ---@type Wezterm
local act = wezterm.action
local config = wezterm.config_builder() ---@type Config

local colors = require("colors.kanagawa").colors
local wave = require("colors.kanagawa").wave

require("events.right-status").setup(wave)
require("events.tab-title").setup(wave)

config.status_update_interval = 1000

config.default_prog = { "pwsh.exe" }
config.set_environment_variables = {
	POWERSHELL_UPDATECHECK = "Off",
}

-- config.color_scheme = "Dracula"
-- config.color_scheme = "flexoki-dark"
config.color_scheme = "Snazzy"

config.font = wezterm.font("0xProto Nerd Font Mono")
config.font_size = 11

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
--
-- config.window_decorations = "RESIZE"
config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"

-- config.window_background_opacity = 0.93
-- config.macos_window_background_blur = 30

config.initial_cols = 120
config.initial_rows = 40

config.leader = {
	key = "a",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}

local function move_pane(key, direction)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ direction, 3 }),
	}
end

config.keys = {
	{ key = "p", mods = "CTRL", action = act.ShowTabNavigator },
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
	{ key = "P", mods = "CTRL|SHIFT", action = act.ShowLauncher },
	{ key = "P", mods = "CTRL|ALT|SHIFT", action = act.ActivateCommandPalette },

	-- enable CTRL + v to paste from system clipboard
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },

	{ key = "\\", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Move to a pane (prompt for which one)
	{ key = "m", mods = "CTRL", action = act.PaneSelect },
	-- use CTRL + [h|j|k|l] to move between panes
	move_pane("h", "Left"),
	move_pane("j", "Down"),
	move_pane("k", "Up"),
	move_pane("l", "Right"),

	{
		-- When we press LEADER + R...
		key = "r",
		mods = "LEADER",
		-- Activate the `resize_panes` keytable
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			-- Ensures the keytable stays active after it handles its
			-- first keypress
			one_shot = false,
			-- Deactivate the keytable after a timeout
			timeout_milliseconds = 2000,
		}),
	},

	--
	-- Move to another tab (next or previous)
	{ key = "{", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "}", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
	-- Use CTRL_SHIFT+S to swap the active pane and another one
	{ key = "s", mods = "CTRL|SHIFT", action = act({ PaneSelect = { mode = "SwapWithActiveKeepFocus" } }) },
	-- Use CTRL+w to close the pane, CTRL_SHIFT+w to close the tab
	{ key = "w", mods = "CTRL", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
	-- Use CTRL+z to enter zoom state
	{ key = "z", mods = "CTRL", action = act.TogglePaneZoomState },

	-- Open config
	{
		key = ",",
		mods = "SUPER|CTRL",
		description = "Open Wezterm configuration in new tab",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
			args = { "nvim", wezterm.config_file },
		}),
	},
}

config.key_tables = {
	resize_panes = {
		resize_pane("h", "Left"),
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("l", "Right"),
	},
}

-- Mouse bindings
-- mimic Windows Terminal selection and copy by right click
config.mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}
--[[
-- Enable status bar
config.status_update_interval = 1000

-- https://www.nordtheme.com/docs/colors-and-palettes
wezterm.GLOBAL.nord = wezterm.GLOBAL.nord
	or {
		-- polar night
		nord0 = "#2E3440",
		nord1 = "#3B4252",
		nord2 = "#434C5E",
		nord3 = "#4C566A",
		-- snow storm
		nord4 = "#D8DEE9",
		nord5 = "#E5E9F0",
		nord6 = "#ECEFF4",
		-- frost
		nord7 = "#8FBCBB",
		nord8 = "#88C0D0",
		nord9 = "#81A1C1",
		nord10 = "#5E81AC",
		-- aurora
		nord11 = "#BF616A",
		nord12 = "#D08770",
		nord13 = "#EBCB8B",
		nord14 = "#A3BE8C",
		nord15 = "#B48EAD",
	}

config.window_frame = {
	font_size = 12.0,
	active_titlebar_bg = wezterm.GLOBAL.nord.nord1,
	inactive_titlebar_bg = wezterm.GLOBAL.nord.nord1,
}

function table.merge(to, from)
	for _, v in ipairs(from) do
		table.insert(to, v)
	end
	return to
end

local format_status = function(icon_name, icon_color, status_text, bg_color)
	if status_text ~= nil then
		return {
			{ Background = { Color = bg_color or wezterm.GLOBAL.nord.nord1 } },
			{ Foreground = { Color = icon_color } },
			{ Text = " " .. wezterm.nerdfonts[icon_name] },
			{ Foreground = { Color = wezterm.GLOBAL.nord.nord6 } },
			{ Text = " " .. status_text .. " " },
		}
	else
		return {
			{ Background = { Color = bg_color or wezterm.GLOBAL.nord.nord1 } },
			{ Foreground = { Color = icon_color } },
			{ Text = " " .. wezterm.nerdfonts[icon_name] },
		}
	end
end

local clock_status = function()
	return format_status("fa_calendar", wezterm.GLOBAL.nord.nord9, wezterm.strftime("%Y/%m/%d %H:%M:%S"))
end

local leader_status = function(window)
	local color = window:leader_is_active() and wezterm.GLOBAL.nord.nord15 or wezterm.GLOBAL.nord.nord4
	local text = window:leader_is_active() and "LEADER" or "normal"
	local bg_color = window:leader_is_active() and wezterm.GLOBAL.nord.nord11 or wezterm.GLOBAL.nord.nord1
	return format_status("md_keyboard_variant", color, text, bg_color)
	----
	--local status = window:leader_is_active() and "LEADER" or "normal"
	--return status
end
--
wezterm.on("update-right-status", function(window, _)
	local status = {}
	local spacer = { { Text = " " } }

	local add_status = function(add)
		if #status == 0 then
			table.merge(status, { { Background = { Color = wezterm.GLOBAL.nord.nord1 } } })
		else
			table.merge(status, spacer)
		end

		table.merge(status, add)
	end

	add_status(clock_status())
	add_status(leader_status(window))

	window:set_right_status(wezterm.format(status))
end)

local function get_cwd(pane)
	-- local cells = {}
	local cwd = ""

	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		if type(cwd_uri) == "userdata" then
			-- Running on a newer version of wezterm and we have
			-- a URL object here, making this simple.
			cwd = cwd_uri.file_path
		else
			-- an older version of wezterm
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				-- and extract the cwd from the uri, decoding %-encoding
				cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end
	end
	return cwd
end

--[[
local function segments_for_right_status(window, pane)
	return {
		get_cwd(pane),
		window:active_workspace(),
		wezterm.strftime("%a %b %-d %H:%M"),
		-- wezterm.hostname(),
		leader_status(window),
	}
end

wezterm.on("update-right-status", function(window, pane)
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	local segments = segments_for_right_status(window, pane)

	local color_scheme = window:effective_config().resolved_palette
	-- Note: the use of wezterm.color.parse here, this returns
	-- a Color object, which comes with functionality for lightening
	-- or darkening the color (amongst other things)
	local bg = wezterm.color.parse(color_scheme.background)
	-- local bg = wezterm.color.parse("#3c1361")
	local fg = color_scheme.foreground

	-- Each powerline segment is going to be colored progressively
	-- darker/lighter depending on whether we're on a dark/light color
	-- scheme. Let's establish the "from" and "to" bounds of our gradient.
	local gradient_to, gradient_from = bg, bg
	-- if appearance.is_dark() then
	-- 	gradient_from = gradient_to:lighten(0.4)
	-- else
	-- 	gradient_from = gradient_to:darken(0.2)
	-- end
	gradient_from = gradient_to:lighten(0.3)

	local gradient = wezterm.color.gradient({
		orientation = "Horizontal",
		colors = { gradient_from, gradient_to },
	}, #segments)

	local elements = {}

	for i, seg in ipairs(segments) do
		local is_first = i == 0

		if is_first then
			table.insert(elements, { Background = { Color = "none" } })
		end
		table.insert(elements, { Foreground = { Color = gradient[i] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })

		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = gradient[i] } })
		table.insert(elements, { Text = " " .. seg .. " " })
	end

	window:set_right_status(wezterm.format(elements))
end)
--]]

return config
