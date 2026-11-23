local M = {}
M.wave = {
	foreground = "#dcd7ba",
	background = "#1f1f28",
	ansi = {
		black = "#090618", -- black
		red = "#c34043",
		green = "#76946a",
		yellow = "#c0a36e",
		blue = "#7e9cd8",
		magenta = "#957fb8",
		cyan = "#6a9589",
		white = "#c8c093",
	},
	bright = {
		black = "#727169",
		red = "#e82424",
		green = "#98bb6c",
		yellow = "#e6c384",
		blue = "#7fb4ca",
		magenta = "#938aa9",
		cyan = "#7aa89f",
		white = "#dcd7ba",
	},
	peachRed = "#ff5d62",
}

M.colors = {
	foreground = M.wave.foreground,
	background = M.wave.background,

	cursor_bg = M.wave.foreground,
	cursor_fg = M.wave.background,
	cursor_border = M.wave.foreground,

	ansi = {
		M.wave.ansi.black,
		M.wave.ansi.red,
		M.wave.ansi.green,
		M.wave.ansi.yellow,
		M.wave.ansi.blue,
		M.wave.ansi.magenta,
		M.wave.ansi.cyan,
		M.wave.ansi.white,
	},

	bright = {
		M.wave.bright.black,
		M.wave.bright.red,
		M.wave.bright.green,
		M.wave.bright.yellow,
		M.wave.bright.blue,
		M.wave.bright.magenta,
		M.wave.bright.cyan,
		M.wave.bright.white,
	},

	selection_bg = M.wave.bright.blue,
	selection_fg = M.wave.ansi.black,

	scrollbar_thumb = M.wave.bright.white,

	split = M.wave.bright.white,

	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },

	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = M.wave.background,

		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = M.wave.background,
			-- The color of the text for the tab
			fg_color = M.wave.foreground,

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Normal",

			-- Specify whether you want "None", "Single", or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",

			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab. The default is false.
			italic = false,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab. The default is false
			strikethrough = false,
		},
		new_tab = {
			bg_color = M.wave.background,
			fg_color = M.wave.foreground,

			-- The same options that where listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = M.wave.background,
			fg_color = M.wave.foreground,
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

return M
