local M = {}

local parse = require("godot-scenetree.parse")
local tree = require("godot-scenetree.tree")
local pickers = require("godot-scenetree.picker").pickers
local config = require("godot-scenetree.config").config

local export = function(node, buf_type)
	return require("godot-scenetree.export").get_export(node, buf_type)
end

function M.setup(opts)
	config = vim.tbl_extend("force", config, opts or {})
end

local last_file = nil

local function open_scene(file)
	vim.schedule(function()
		local current_buf = vim.api.nvim_get_current_buf()

		local lines, nodes = tree.render(parse.parse_scene(file))

		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
		vim.bo[buf].modifiable = false

		local win = vim.api.nvim_open_win(buf, true, {
			split = "right",
		})
		vim.api.nvim_set_current_win(win)

		vim.keymap.set("n", config.keymaps.export_node, function()
			local pos = vim.api.nvim_win_get_cursor(0)[1]
			local selected = nodes[pos]
			vim.api.nvim_set_current_buf(current_buf)
			vim.api.nvim_win_close(win, false)
			vim.fn.setreg(vim.v.register, export(selected, vim.bo[current_buf].filetype))
		end, { buffer = buf })

		vim.keymap.set("n", "q", function()
			vim.api.nvim_win_close(win, false)
		end, { buffer = buf })

		vim.keymap.set("n", config.keymaps.open_picker, function()
			vim.api.nvim_win_close(win, false)
			M.pick()
		end, { buffer = buf })
	end)
end

function M.pick()
	local files = vim.fn.glob(vim.fn.getcwd() .. "/**/*.tscn", false, true)
	pickers[config.picker](files, function(file)
		last_file = file
		open_scene(file)
	end)
end

vim.api.nvim_create_user_command("Scenetree", function()
	if last_file then
		open_scene(last_file)
	else
		M.pick()
	end
end, {})

return M
