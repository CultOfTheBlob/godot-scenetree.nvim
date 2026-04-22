local M = {}

M.pickers = {
	["mini.pick"] = function(files, on_choose)
		local MiniPick = require("mini.pick")
		MiniPick.start({
			source = {
				name = "Scenes",
				items = files,
				choose = on_choose,
			},
		})
	end,
	["telescope"] = function(files, on_choose)
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		pickers
			.new({}, {
				finder = finders.new_table({ results = files }),
				attach_mappings = function(prompt_buf)
					actions.select_default:replace(function()
						actions.close(prompt_buf)
						on_choose(action_state.get_selected_entry()[1])
					end)
					return true
				end,
			})
			:find()
	end,
}

return M
