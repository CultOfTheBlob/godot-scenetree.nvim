local M = {}

local parse = require("godot-scenetree.parse")
local tree = require("godot-scenetree.tree")
local pickers = require("godot-scenetree.picker").pickers
local config = require("godot-scenetree.config").config
local signals = require("godot-scenetree.signals")
local utils = require("godot-scenetree.utils")

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
		local buf_type = vim.bo[current_buf].filetype

		local lines, nodes = tree.render(parse.parse_scene(file))

		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
		vim.bo[buf].modifiable = false

		local win = vim.api.nvim_open_win(buf, true, {
			split = config.split,
			width = config.width,
		})
		vim.api.nvim_set_current_win(win)

		vim.keymap.set("n", config.keymaps.export_node, function()
			local pos = vim.api.nvim_win_get_cursor(0)[1]
			local selected = nodes[pos]
			vim.api.nvim_set_current_buf(current_buf)
			vim.api.nvim_win_close(win, false)
			vim.fn.setreg(vim.v.register, export(selected, buf_type))
		end, { buffer = buf })

		local connecting = false
		local from_node = nil
		local ns = vim.api.nvim_create_namespace("scenetree_connect")

		vim.keymap.set("n", config.keymaps.attach_signal, function()
			local pos = vim.api.nvim_win_get_cursor(0)[1]
			local selected = nodes[pos]

			if not connecting then
				connecting = true
				from_node = selected

				vim.api.nvim_buf_set_extmark(buf, ns, pos - 1, 0, {
					virt_text = { { " (from)", "Comment" } },
					virt_text_pos = "eol",
				})
			else
				connecting = false
				vim.api.nvim_buf_set_extmark(buf, ns, pos - 1, 0, {
					virt_text = { { " (to)", "Comment" } },
					virt_text_pos = "eol",
				})

				if from_node == nil then
					vim.notify("No source node selected", vim.log.levels.ERROR)
					connecting = false
					return
				end

				local to_node = selected
				local node_signals = signals.get_signals(from_node.type)

				pickers[config.picker](signals.to_string(node_signals, buf_type), function(signal)
					vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
					vim.api.nvim_set_current_buf(current_buf)
					vim.api.nvim_win_close(win, false)
					vim.fn.setreg(vim.v.register, signals.to_code(from_node.name, signal, buf_type))
					signals.add_to_scene(file, signal, from_node, utils.get_full_path(to_node), buf_type)
				end)
			end
		end, { buffer = buf })

		vim.keymap.set("n", config.keymaps.open_picker, function()
			vim.api.nvim_win_close(win, false)
			M.pick()
		end, { buffer = buf })

		vim.keymap.set("n", "q", function()
			vim.api.nvim_win_close(win, false)
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
