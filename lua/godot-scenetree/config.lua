local M = {}

M.config = {
	picker = "mini.pick",
	width = 50,
	split = "right",
	mappings = {
		open_picker = "p",
		export_node = "<C-x>",
		get_node_path = "<C-c>",
		get_onready_node = "<C-o>",
		attach_signal = "<C-s>",
	},
}

return M
