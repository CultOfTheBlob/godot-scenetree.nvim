local M = {}

function M.snake_case(s)
	s = string.gsub(s, "(%l)(%u)", "%1_%2")
	s = string.gsub(s, "(%u+)(%u%l)", "%1_%2")
	s = string.gsub(s, "(%l)(%d)", "%1_%2")
	return string.lower(s)
end

function M.pascal_case(str)
	str = str:gsub("_(%d+)(%a)", function(n, c)
		return n .. c:upper()
	end)
	str = str:gsub("_(%a)", function(c)
		return c:upper()
	end)
	str = str:gsub("^%a", function(c)
		return c:upper()
	end)
	return str
end

function M.camel_case(str)
	str = str:gsub("_(%d+)(%a)", function(n, c)
		return n .. c:upper()
	end)
	str = str:gsub("_(%a)", function(c)
		return c:upper()
	end)
	str = str:gsub("^%a", function(c)
		return c:lower()
	end)
	return str
end

function M.get_full_path(node)
	local path = node.name
	local parent = node.parent

	if parent == nil then
		return "."
	end

	while parent ~= nil and parent.parent ~= nil do
		path = parent.name .. "/" .. path
		parent = parent.parent
	end

	return path
end

return M
