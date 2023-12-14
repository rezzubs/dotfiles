---@diagnostic disable: lowercase-global
local M = {
  mod = "Mod4"
}

local gears = require("gears")
local awful = require("awful")

-- KEYBINDS --
globalkeys = gears.table.join(
  awful.key({ M.mod }, "s",
    require("awful.hotkeys_popup").show_help,
    { description = "show help", group = "awesome" }
  ),

  awful.key({ M.mod }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),

  awful.key({ M.mod }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),

  -- Layout manipulation
  awful.key({ M.mod, "Shift" }, "j",
    function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }
  ),

  awful.key({ M.mod, "Shift" }, "k",
    function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }
  ),

  awful.key({ M.mod }, "comma",
    function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }
  ),

  awful.key({ M.mod }, "period",
    function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }
  ),

  awful.key({ M.mod }, "u",
    awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }
  ),

  -- Standard program
  awful.key({ M.mod }, "t",
    function() awful.spawn(Terminal) end,
    { description = "open a terminal", group = "launcher" }
  ),

  awful.key({ M.mod, "Control" }, "r",
    awesome.restart,
    { description = "reload awesome", group = "awesome" }
  ),

  awful.key({ M.mod, "Shift" }, "q",
    awesome.quit,
    { description = "quit awesome", group = "awesome" }
  ),

  awful.key({ M.mod }, "l",
    function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }
  ),

  awful.key({ M.mod }, "h",
    function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }
  ),

  awful.key({ M.mod, "Shift" }, "h",
    function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }
  ),

  awful.key({ M.mod, "Shift" }, "l",
    function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }
  ),

  awful.key({ M.mod, "Control" }, "h",
    function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }
  ),

  awful.key({ M.mod, "Control" }, "l",
    function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }
  ),

  awful.key({ M.mod }, "Tab",
    function() awful.layout.inc(1) end,
    { description = "cycle layout +", group = "layout" }
  ),

  awful.key({ M.mod, "Shift" }, "Tab",
    function() awful.layout.inc(-1) end,
    { description = "cycle layout -", group = "layout" }
  ),

  -- Prompt (currently for error testing)
  awful.key({ M.mod }, "r",
    function() awful.screen.focused().mypromptbox:run() end,
    { description = "run prompt", group = "launcher" }
  ),

  awful.key({ M.mod }, "p",
    function() require("menubar").show() end,
    { description = "show the menubar", group = "launcher" }
  ),

  awful.key({ M.mod }, "b",
    function() awful.spawn("firefox-bin") end,
    { description = "launch browser", group = "apps" }
  )
)

clientkeys = gears.table.join(
  awful.key({ M.mod, "Shift" }, "period",
    function(c)
      c:move_to_screen(c.screen.index + 1)
    end
  ),

  awful.key({ M.mod, "Shift" }, "comma",
    function(c)
      c:move_to_screen(c.screen.index - 1)
    end
  ),

  awful.key({ M.mod }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),

  awful.key({ M.mod }, "w",
    function(c) c:kill() end,
    { description = "close", group = "client" }
  ),

  awful.key(
    { M.mod }, "v",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),

  awful.key(
    { M.mod, "Control" }, "Return",
    function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }
  ),

  awful.key({ M.mod }, "o",
    function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }
  ),

  awful.key({ M.mod }, "t",
    function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }
  ),

  awful.key({ M.mod }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "client" }),

  awful.key({ M.mod, "Control" }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }),

  awful.key({ M.mod, "Shift" }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 6 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ M.mod }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ M.mod, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ M.mod, "Shift" }, "#" .. i + 9,
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
    awful.key({ M.mod, "Control", "Shift" }, "#" .. i + 9,
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
  awful.button({ M.mod }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ M.mod }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

root.keys(globalkeys)

return M
