hl.on( "hyprland.start", function ()

	-- Makes sure the XDG_DESKTOP_PORTAL is properly started on hyprland launch
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP && systemctl --user start hyprland-session.target")

	-- hl.exec_cmd("hyprmoncfgd")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("slack")
	hl.exec_cmd("neomutt-solo")
	hl.exec_cmd("vesktop")
	hl.exec_cmd("signal-desktop")
	hl.exec_cmd("hypridle")
end)
