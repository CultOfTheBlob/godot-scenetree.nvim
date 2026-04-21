local parse = require("godot-scenetree.parse")
local tree = require("godot-scenetree.tree")

local M = {}

function M.setup(_)
	vim.api.nvim_create_user_command("Scenetree", function()
		local scene_path = vim.fn.getcwd() .. "/scenes/basic.tscn"

		local current_buf = vim.api.nvim_get_current_buf()

		local lines, nodes = tree.render(parse.parse_scene(scene_path))

		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)

		local win = vim.api.nvim_open_win(buf, true, {
			split = "right",
		})

		vim.keymap.set("n", "gg", function()
			local pos = vim.api.nvim_win_get_cursor(0)[1]
			local selected = nodes[pos]

			vim.api.nvim_set_current_buf(current_buf)
			vim.api.nvim_win_close(win, false)
			vim.fn.setreg(vim.v.register, selected.name)
		end, { buffer = buf })

		vim.keymap.set("n", "q", function()
			vim.api.nvim_win_close(win, false)
		end, { buffer = buf })
	end, {})
end

return M
