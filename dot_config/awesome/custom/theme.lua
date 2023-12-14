local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local surface = require("gears.surface")
local shape = require("gears.shape")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local M = {}

local cp = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}

M.font = "sans 8"

M.bg_normal = cp.base
M.bg_focus = cp.surface0
M.bg_urgent = cp.yellow
M.bg_minimize = "#444444"
M.bg_systray = M.bg_normal

M.fg_normal = cp.text
M.fg_focus = cp.mauve
M.fg_urgent = cp.yellow
M.fg_minimize = "#ffffff"

M.useless_gap = 10
M.border_width = 2
M.border_normal = cp.base
M.border_focus = cp.lavender
M.border_marked = cp.yellow

M.titlebar_bg_normal = cp.mantle
M.titlebar_bg_focus = cp.crust
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"


-- Generate taglist squares:
local taglist_square_size = dpi(4)
M.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, M.fg_normal
)
M.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, M.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
M.menu_submenu_icon = themes_path .. "default/submenu.png"
M.menu_height = dpi(15)
M.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

local function circle_button(color)
  return surface.load_from_shape(50, 50, function(cr, w, h)
    shape.circle(cr, w, h, math.min(w, h) / 3.2)
  end, color)
end

local close_button = circle_button(cp.maroon)
local maximize_button = circle_button(cp.yellow)
local minimize_button = circle_button(cp.green)

M.titlebar_close_button_normal = close_button
M.titlebar_close_button_focus = close_button

M.titlebar_minimize_button_normal = minimize_button
M.titlebar_minimize_button_focus = minimize_button

M.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
M.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
M.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
M.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

M.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
M.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
M.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
M.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

M.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
M.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
M.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
M.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

M.titlebar_maximized_button_normal_inactive = maximize_button
M.titlebar_maximized_button_focus_inactive = maximize_button
M.titlebar_maximized_button_normal_active = maximize_button
M.titlebar_maximized_button_focus_active = maximize_button

M.wallpaper = "~/.fehbg"

-- You can use your own layout icons like this:
M.layout_fairh = themes_path .. "default/layouts/fairhw.png"
M.layout_fairv = themes_path .. "default/layouts/fairvw.png"
M.layout_floating = themes_path .. "default/layouts/floatingw.png"
M.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
M.layout_max = themes_path .. "default/layouts/maxw.png"
M.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
M.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
M.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
M.layout_tile = themes_path .. "default/layouts/tilew.png"
M.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
M.layout_spiral = themes_path .. "default/layouts/spiralw.png"
M.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
M.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
M.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
M.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
M.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
M.awesome_icon = theme_assets.awesome_icon(
  M.menu_height, M.bg_focus, M.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
M.icon_theme = "Papirus"

return M
