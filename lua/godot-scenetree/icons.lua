local M = {}

function M.get_icon(node_type)
	local icon = ""

	if string.match(node_type, "Timer") then
		icon = ""
		goto continue
	end
	if string.match(node_type, "Canvas") then
		icon = ""
		goto continue
	end
	if string.match(node_type, "Navigation") then
		icon = "󰍎"
		goto continue
	end
	if string.match(node_type, "Animation") then
		icon = "󰤺"
		goto continue
	end
	if string.match(node_type, "Joint") then
		icon = "󱕆"
		goto continue
	end
	if string.match(node_type, "Audio") then
		icon = ""
		goto continue
	end
	if string.match(node_type, "Light") then
		icon = ""
		goto continue
	end
	if string.match(node_type, "Camera") then
		icon = ""
		goto continue
	end
	if string.match(node_type, "3D") then
		icon = "󰆧"
		goto continue
	end
	if string.match(node_type, "2D") then
		icon = ""
		goto continue
	end

	::continue::
	return icon
end

return M
