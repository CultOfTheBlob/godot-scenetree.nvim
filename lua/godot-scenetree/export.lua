local M = {}

local utils = require("godot-scenetree.utils")

function M.get_export(node, buf_type)
	if buf_type == "cs" then
		return "[Export]" .. "\n" .. "private" .. " " .. node.type .. " " .. node.name .. ";"
	end

	return "@export var" .. " " .. utils.snake_case(node.name) .. ":" .. " " .. node.type
end

return M
