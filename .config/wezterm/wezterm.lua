local wezterm = require("wezterm")

local colorscheme = "Catppuccin Mocha"
local colors = wezterm.color.get_builtin_schemes()[colorscheme]

local config = {
	window_decorations = "RESIZE",
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	color_scheme = colorscheme,
	font_size = 14,
	show_new_tab_button_in_tab_bar = false,
}

return config
