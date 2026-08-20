local mainMod = "SUPER"
local modShift = "SUPER + SHIFT"
local modCtrl = "SUPER + CTRL"
local ultraMod = "SUPER + CTRL + SHIFT"

-- Rofi launchers
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(MENU))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("rofi -show ssh"))
hl.bind(modCtrl .. " + E", hl.dsp.exec_cmd("rofi -show power -modes 'power:rofi_power'"))
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd("rofi -show mount -modes 'mount:rofi_mount'"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("rofi -show unmount -modes 'unmount:rofi_unmount'"))
hl.bind(modShift .. " + P", hl.dsp.exec_cmd("rofi -show pass -modes 'pass:rofi_pass'"))

-- Launch programs
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(TERMINAL))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(BROWSER))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("foot -c $HOME/.config/foot/float.ini"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("foot -c $HOME/.config/foot/float.ini -e ikhal"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("foot -c $HOME/.config/foot/float.ini -e ranger"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("foot -c $HOME/.config/foot/float.ini --working-directory=$HOME/nixos"))

hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("noctalia msg screenshot-region"))

-- Hyprland controls
hl.bind(modCtrl .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(modShift .. " + Q", hl.dsp.window.close())

hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("noctalia msg session lock"))

-- Window controls
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(modShift .. " + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(modShift .. " + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
hl.bind(modShift .. " + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(modShift .. " + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))

hl.bind(modCtrl .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(modCtrl .. " + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(modCtrl .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(modCtrl .. " + L", hl.dsp.window.move({ direction = "right" }))

hl.bind(modShift .. " + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+ F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(modShift .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next({ floating = true, tiled = true }))

-- Workspace controls
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(modShift .. " + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
    hl.bind(ultraMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = 11 }))
hl.bind(mainMod .. " + equal", hl.dsp.focus({ workspace = 12 }))
hl.bind(modShift .. " + minus", hl.dsp.window.move({ workspace = 11, follow = false }))
hl.bind(modShift .. " + equal", hl.dsp.window.move({ workspace = 12, follow = false }))
hl.bind(ultraMod .. " + minus", hl.dsp.window.move({ workspace = 11 }))
hl.bind(ultraMod .. " + equal", hl.dsp.window.move({ workspace = 12 }))

-- Move workspace to adjacent monitors
hl.bind(modShift .. " + comma", hl.dsp.workspace.move({ monitor = "left" }))
hl.bind(modShift .. " + period", hl.dsp.workspace.move({ monitor = "right" }))

-- Mouse controls
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media/system controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer sset Master 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer sset Master 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("amixer set Master 1+ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("xbacklight -inc 5"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("xbacklight -dec 5"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
