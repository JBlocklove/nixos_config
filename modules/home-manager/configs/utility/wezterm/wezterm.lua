local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- [font] and [window] equivalents
config.font_size = 10.0
config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.front_end = "OpenGL"
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.freetype_load_flags = "NO_HINTING"
config.cell_width = 0.9
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
  left = 4, right = 4,
  top = 4, bottom = 4,
}
config.enable_tab_bar = false

-- [colors] Moonlight equivalent
config.colors = {
  background = "#212337",
  foreground = "#dce2f5",
  cursor_fg = "#14162a",
  cursor_bg = "#dce2f5",
  cursor_border = "#2df4c0",

  ansi = {
    "#131421", -- black
    "#ff757f", -- red
    "#2df4c0", -- green
    "#ffc777", -- yellow
    "#4f99ff", -- blue
    "#c4a2ff", -- magenta
    "#04dff9", -- cyan
    "#e4f3fa", -- white
  },
  brights = {
    "#363645", -- bright black
    "#f67f81", -- bright red
    "#6bf1ce", -- bright green
    "#ffdca9", -- bright yellow
    "#86b0ea", -- bright blue
    "#d6ccff", -- bright magenta
    "#41cfd9", -- bright cyan
    "#8585bb", -- bright white
  },
}
config.bold_brightens_ansi_colors = false

-- [[hints.enabled]] equivalent
-- WezTerm has clickable URLs by default, but to map a "hint" mode to Alt+F:
config.keys = {
  {
    key = 'f',
    mods = 'ALT',
    action = act.QuickSelectArgs {
      label = 'open url',
      -- WezTerm uses standard Lua regex escapes. Here is a simplified 
      -- version of your regex that catches standard web protocols:
      patterns = {
        "https?://\\S+",
        "gemini://\\S+",
        "ipfs://\\S+",
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    },
  },
  
  -- [keyboard] equivalents
  -- Note: Lua uses \x1b for the escape character instead of \u001b
  { key = 'l', mods = 'CTRL', action = act.SendString("\x1bOC") },
  { key = 'h', mods = 'CTRL', action = act.SendString("\x1bOD") },
  { key = 'k', mods = 'CTRL', action = act.SendString("\x1bOA") },
  { key = 'j', mods = 'CTRL', action = act.SendString("\x1bOB") },

  { key = 'L', mods = 'CTRL|SHIFT', action = act.SendString("\x1b[108;6u") },
  { key = 'H', mods = 'CTRL|SHIFT', action = act.SendString("\x1b[104;6u") },
  { key = 'K', mods = 'CTRL|SHIFT', action = act.SendString("\x1b[107;6u") },
  { key = 'J', mods = 'CTRL|SHIFT', action = act.SendString("\x1b[106;6u") },
  { key = 'X', mods = 'CTRL|SHIFT', action = act.SendString("\x1b[120;6u") },
}

return config
