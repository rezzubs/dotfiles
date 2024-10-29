local wezterm = require "wezterm"

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

function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end
    return tab_info.active_pane.title
end

function right_circle(bg, fg)
    return wezterm.format {
        { Background = { Color = bg } },
        { Foreground = { Color = fg } } ,
        { Text = wezterm.nerdfonts.ple_right_half_circle_thick },
    }
end

function left_circle(bg, fg)
    return wezterm.format {
        { Background = { Color = bg } },
        { Foreground = { Color = fg } } ,
        { Text = wezterm.nerdfonts.ple_left_half_circle_thick },
    }
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local left = ""
        local right = ""

        local current_id = tab.tab_index + 1
        local prev = tabs[current_id - 1]
        local next = tabs[current_id + 1]

        if tab.is_active then
            if next == nil then
                right = right_circle(colors.tab_bar.background, colors.tab_bar.active_tab.bg_color)
            end
            if prev == nil then
                left = " "
            end
        else
            if next == nil then
                right = right_circle(colors.tab_bar.background, colors.tab_bar.inactive_tab.bg_color)
            elseif next.is_active then
                right = " " .. left_circle(colors.tab_bar.inactive_tab.bg_color, colors.tab_bar.active_tab.bg_color)
            else
                right = " "
            end

            if prev == nil then
                left = " "
            elseif prev.is_active then
                left = right_circle(colors.tab_bar.inactive_tab.bg_color, colors.tab_bar.active_tab.bg_color) .. " "
            else
                left = " "
            end
        end

        return {
            { Text = left .. tab_title(tab) .. right }
        }
    end
)

return config
