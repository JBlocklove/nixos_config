-- Open apps in specific workspaces
hl.window_rule({
	name = "signal_workspace",
	match = { class = "signal" },
	workspace = 11,
})
hl.window_rule({
	name = "vesktop_workspace",
	match = { class = "vesktop" },
	workspace = 11,
})
hl.window_rule({
	name = "slack_workspace",
	match = { class = "slack" },
	workspace = 12,
})
hl.window_rule({
	name = "neomutt_workspace",
	match = { title = "neomutt" },
	workspace = 12,
})

-- Floating terminal
hl.window_rule({
	name = "float_terminal",
	match = { title = "foot - floating" },
	float = true,
	size = { 750, 550 },
})

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
