local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

awful.rules.rules = {
  { -- global rule
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      ontop = false
    }
  },

  { -- Add titlebars to floating clients and dialogs
    rule_any = {
      type = { "floating", "dialog" },
      floating = { true }
    },
    properties = {
      titlebars_enabled = true,
      ontop = true
    }
  },

}

return M
