require("awful.autofocus")
local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")

Terminal = "wezterm"
menubar.utils.Terminal = Terminal -- Set the terminal for applications that require it

beautiful.init(require("custom.theme"))

require("custom.notifications")

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating,
}

awful.screen.connect_for_each_screen(function(s)
  awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
end)

require("custom.binds")

require("custom.rules")

require("custom.signals")
