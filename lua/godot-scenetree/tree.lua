local M = {}

local icons = require("godot-scenetree.icons")

local function build_tree(nodes)
	local root = nil
	local by_name = {}

	for _, node in ipairs(nodes) do
		local tree_node = { name = node.name, type = node.type, children = {} }
		by_name[node.name] = tree_node
		if node.parent == "" then
			root = tree_node
		end
	end

	for _, node in ipairs(nodes) do
		if node.parent == "." and root ~= nil then
			table.insert(by_name[root.name].children, by_name[node.name])
		elseif node.parent ~= "" then
			table.insert(by_name[node.parent].children, by_name[node.name])
		end
	end
	return root
end

local function draw_tree(node, lines, nodes, depth, prefix, is_last)
	lines = lines or {}
	nodes = nodes or {}
	depth = depth or 0
	prefix = prefix or ""
	is_last = is_last == nil and true or is_last

	local connector = depth == 0 and "" or (is_last and "└─ " or "├─ ")
	table.insert(lines, prefix .. connector .. icons.get_icon(node.type) .. " " .. node.name)
	table.insert(nodes, node)

	local child_prefix = prefix .. (depth == 0 and "" or (is_last and "   " or "│  "))
	for i, child in ipairs(node.children) do
		draw_tree(child, lines, nodes, depth + 1, child_prefix, i == #node.children)
	end

	return lines, nodes
end

function M.render(scene)
	local root = build_tree(scene)
	local lines, nodes = draw_tree(root)

	return lines, nodes
end

return M
