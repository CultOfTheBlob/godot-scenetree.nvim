local M = {}

local function snake_case(s)
	s = string.gsub(s, "(%l)(%u)", "%1_%2")
	s = string.gsub(s, "(%u+)(%u%l)", "%1_%2")
	return string.lower(s)
end

function M.get_export(node, buf_type)
	if buf_type == "gdscript" then
		return "@export var" .. " " .. snake_case(node.name) .. ":" .. " " .. node.type
	end

	if buf_type == "cs" then
		return "[Export]" .. "\n" .. "private" .. " " .. node.type .. " " .. node.name .. ";"
	end

	return "@export var" .. " " .. snake_case(node.name) .. ":" .. " " .. node.type
end

return M
