-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

local cp = {
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
  overlay1 = "#7f849c",
  surface0 = "#313244",
  text = "#cdd6f4",
  mauve = "#cba6f7",
  transparent = "none",
}

config.enable_wayland = false

config.color_scheme = 'catppuccin-mocha'
-- config.window_background_opacity = 0

config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 15

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.window_frame = {
  active_titlebar_bg = cp.mantle,
  inactive_titlebar_bg = cp.base,
}

config.colors = {
  tab_bar = {
    background = cp.transparent,

    active_tab = {
      bg_color = cp.base,
      fg_color = cp.text,
      intensity = "Bold"
    },

    inactive_tab = {
      bg_color = cp.mantle,
      fg_color = cp.overlay1,
    },

    new_tab = {
      bg_color = cp.transparent,
      fg_color = cp.text,
    },

    inactive_tab_hover = {
      bg_color = cp.surface0,
      fg_color = cp.text,
    },

    new_tab_hover = {
      bg_color = cp.transparent,
      fg_color = cp.mauve,
    }
  }
}

config.keys = {
  { key = "k", mods = "ALT", action = wezterm.action.ScrollByLine(-1) },
  { key = "j", mods = "ALT", action = wezterm.action.ScrollByLine(1) },
}

-- and finally, return the configuration to wezterm
return config
