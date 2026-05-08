local wezterm = require 'wezterm'

local config = dofile(wezterm.config_dir .. '/wezterm.lua')

config.bold_brightens_ansi_colors = true
config.default_prog = { 'neomutt' }

return config
