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
	signals.preload()

	config = vim.tbl_extend("force", config, opts or {})
end

local last_file = nil

local function open_scene(file)
	vim.schedule(function()
		local ns = vim.api.nvim_create_namespace("scenetree_connect")

		local current_buf = vim.api.nvim_get_current_buf()
		local buf_type = vim.bo[current_buf].filetype

		local lines, nodes, highlights = tree.render(parse.parse_scene(file))

		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
		vim.bo[buf].modifiable = false

		for _, h in ipairs(highlights) do
			local line_content = lines[h.line + 1]
			local line_len = #line_content
			vim.api.nvim_buf_set_extmark(buf, ns, h.line, h.col_start, {
				end_col = math.min(h.col_end, line_len),
				hl_group = h.group,
			})
		end

		local win = vim.api.nvim_open_win(buf, true, {
			split = config.split,
			width = config.width,
		})
		vim.api.nvim_set_current_win(win)
		vim.wo[win].cursorline = true

		vim.keymap.set("n", config.keymaps.export_node, function()
			local pos = vim.api.nvim_win_get_cursor(0)[1]
			local selected = nodes[pos]
			vim.api.nvim_set_current_buf(current_buf)
			vim.api.nvim_win_close(win, false)
			vim.fn.setreg(vim.v.register, export(selected, buf_type))
		end, { buffer = buf })

		vim.keymap.set("n", config.keymaps.get_node_path, function()
			local pos = vim.api.nvim_win_get_cursor(0)[1]
			local selected = nodes[pos]
			vim.api.nvim_set_current_buf(current_buf)
			vim.api.nvim_win_close(win, false)

			if buf_type == "cs" then
				vim.fn.setreg(
					vim.v.register,
					"GetNode<" .. selected.type .. '>("' .. utils.get_full_path(selected) .. '")'
				)
			else
				vim.fn.setreg(vim.v.register, "$" .. utils.get_full_path(selected))
			end
		end, { buffer = buf })

		vim.keymap.set("n", config.keymaps.get_onready_node, function()
			local pos = vim.api.nvim_win_get_cursor(0)[1]
			local selected = nodes[pos]
			vim.api.nvim_set_current_buf(current_buf)
			vim.api.nvim_win_close(win, false)

			if buf_type == "cs" then
				vim.fn.setreg(
					vim.v.register,
					utils.camel_case(selected.name)
						.. " = GetNode<"
						.. selected.type
						.. '>("'
						.. utils.get_full_path(selected)
						.. '")'
				)
			else
				vim.fn.setreg(
					vim.v.register,
					"@onready var "
						.. utils.snake_case(selected.name)
						.. ": "
						.. selected.type
						.. " = "
						.. "$"
						.. utils.get_full_path(selected)
				)
			end
		end, { buffer = buf })

		local connecting = false
		local from_node = nil
		vim.keymap.set("n", config.keymaps.attach_signal, function()
			vim.wo[win].winbar = "%#DiagnosticWarn# Connecting...%*"

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

				vim.wo[win].winbar = ""
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
