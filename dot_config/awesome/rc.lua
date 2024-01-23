require("awful.autofocus")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local menubar = require("menubar")

Terminal = "wezterm" -- FIXME
menubar.utils.Terminal = Terminal -- Set the terminal for applications that require it
local modkey = "Mod4"

require("custom.notifications")

do
  local theme = {}

  theme.wallpaper = "~/.fehbg" -- FIXME
  theme.useless_gap = 0
  theme.border_width = 2
  theme.icon_theme = "Papirus"
  theme.font = "sans 8"

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local surface = require("gears.surface")
local shape = require("gears.shape")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

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

theme.bg_normal = cp.base
theme.bg_focus = cp.surface0
theme.bg_urgent = cp.yellow
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = cp.text
theme.fg_focus = cp.mauve
theme.fg_urgent = cp.yellow
theme.fg_minimize = "#ffffff"

theme.border_normal = cp.base
theme.border_focus = cp.lavender
theme.border_marked = cp.yellow

theme.titlebar_bg_normal = cp.mantle
theme.titlebar_bg_focus = cp.crust

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, theme.fg_normal
)

theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

local function circle_button(color)
  return surface.load_from_shape(50, 50, function(cr, w, h)
    shape.circle(cr, w, h, math.min(w, h) / 3.2)
  end, color)
end

local close_button = circle_button(cp.maroon)
local maximize_button = circle_button(cp.yellow)
local minimize_button = circle_button(cp.green)

theme.titlebar_close_button_normal = close_button
theme.titlebar_close_button_focus = close_button

theme.titlebar_minimize_button_normal = minimize_button
theme.titlebar_minimize_button_focus = minimize_button

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = maximize_button
theme.titlebar_maximized_button_focus_inactive = maximize_button
theme.titlebar_maximized_button_normal_active = maximize_button
theme.titlebar_maximized_button_focus_active = maximize_button

theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

beautiful.init(theme)
end

awful.layout.layouts = {
  awful.layout.suit.max,
}

awful.screen.connect_for_each_screen(function(s)
  -- Default layout for each screen
  local layout = (s.index == 2)
      and awful.layout.suit.tile.left
      or awful.layout.suit.tile.right
  awful.tag({ "1", "2", "3", "4", "5", "6" }, s, layout)
end)

globalkeys = gears.table.join(
  awful.key({ modkey }, "e",
    function()
      awful.spawn("emacsclient -c --alternate-editor emacs")
    end
  ),

  awful.key({ modkey }, "d",
    function()
      awful.spawn("discord")
    end
  ),

  awful.key({ modkey, "Shift", "Control", "Mod1" }, "r",
    function()
      awful.spawn("loginctl reboot")
    end
  ),

  awful.key({ modkey, "Shift", "Control", "Mod1" }, "s",
    function()
      awful.spawn("loginctl poweroff")
    end
  ),

  awful.key({ modkey, "Shift", "Mod1" }, "s",
    function()
      awful.spawn("loginctl suspend")
    end
  ),

  awful.key({}, "Print",
    function()
      awful.spawn("flameshot gui")
    end
  ),

  awful.key({ modkey }, "s",
    require("awful.hotkeys_popup").show_help,
    { description = "show help", group = "awesome" }
  ),

  awful.key({ modkey }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),

  awful.key({ modkey }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j",
    function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }
  ),

  awful.key({ modkey, "Shift" }, "k",
    function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }
  ),

  awful.key({ modkey }, "l",
    function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "client" }
  ),

  awful.key({ modkey }, "h",
    function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "client" }
  ),

  awful.key({ modkey }, "u",
    awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }
  ),

  -- Standard program
  awful.key({ modkey }, "t",
    function() awful.spawn(Terminal) end,
    { description = "open a terminal", group = "launcher" }
  ),

  awful.key({ modkey, "Control" }, "r",
    awesome.restart,
    { description = "reload awesome", group = "awesome" }
  ),

  awful.key({ modkey, "Shift" }, "q",
    awesome.quit,
    { description = "quit awesome", group = "awesome" }
  ),

  awful.key({ modkey }, "=",
    function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }
  ),

  awful.key({ modkey }, "-",
    function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }
  ),

  awful.key({ modkey }, "i",
    function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }
  ),

  awful.key({ modkey }, "o",
    function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }
  ),

  awful.key({ modkey }, "Tab",
    function() awful.layout.inc(1) end,
    { description = "cycle layout +", group = "layout" }
  ),

  awful.key({ modkey, "Shift" }, "Tab",
    function() awful.layout.inc(-1) end,
    { description = "cycle layout -", group = "layout" }
  ),

  awful.key({ modkey }, "r",
    function() require("menubar").show() end,
    { description = "show the menubar", group = "launcher" }
  ),

  awful.key({ modkey }, "b",
    function() awful.spawn("firefox-bin") end,
    { description = "launch browser", group = "apps" }
  )
)

clientkeys = gears.table.join(
  awful.key({ modkey }, "Return",
    function(c)
      local master = awful.client.getmaster()
      if c == master then
        awful.client.setmaster(awful.client.focus.history.get(c.screen, 0))
      else
        awful.client.focus.history.add(master)
        awful.client.setmaster(c)
      end
    end,
    {
      description = "set client as master or replace with previous.",
      group = "client",
    }
  ),

  awful.key({ modkey, "Shift" }, "l",
    function(c)
      c:move_to_screen(c.screen.index + 1)
    end
  ),

  awful.key({ modkey, "Shift" }, "h",
    function(c)
      c:move_to_screen(c.screen.index - 1)
    end
  ),

  awful.key({ modkey }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),

  awful.key({ modkey }, "w",
    function(c) c:kill() end,
    { description = "close", group = "client" }
  ),

  awful.key(
    { modkey }, "v",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),

  awful.key(
    { modkey, "Control" }, "Return",
    function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }
  ),

  awful.key({ modkey }, "t",
    function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 6 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

root.keys(globalkeys)

require("custom.rules")

require("custom.signals")
