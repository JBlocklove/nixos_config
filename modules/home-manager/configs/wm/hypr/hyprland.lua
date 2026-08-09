-- Program definitions
TERMINAL = "foot"
FILEMANAGER = TERMINAL .. "-e ranger"
MENU = "rofi -show run"
BROWSER = "librewolf"

-- require references to lua directory
-- Monitors, managed by hyprmoncfg
require( "monitors" )

require( "hyprconf/autostart" )
require( "hyprconf/input" )
require( "hyprconf/workspaces_windows" )
require( "hyprconf/style" )
require( "hyprconf/keybindings" )

-- Specific program handling options
require( "hyprconf/programs" )
