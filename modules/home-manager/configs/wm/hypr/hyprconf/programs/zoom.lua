hl.window_rule({
	name = "zoom_popup_fix",
	match = {
		class = "zoom",
		title = "menu window"
	},
	stay_focused = true,
})

hl.window_rule({
	name = "zoom_annotate_toolbar_fix",
	match = {
		class = "zoom",
		title = "annotate_toolbar",
	},
	float = false,
	no_anim = true,
	no_focus = true,
	no_shadow = true,
	border_size = 0,
})
