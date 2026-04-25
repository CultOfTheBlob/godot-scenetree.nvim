local M = {}

local icons = require("godot-scenetree.icons")

local function build_tree(nodes)
	local root = nil
	local by_path = {}

	for _, node in ipairs(nodes) do
		local tree_node = {
			name = node.name,
			type = node.type,
			children = {},
			parent = nil,
			has_script = node.has_script,
		}

		local path
		if node.parent == "" then
			path = node.name
			root = tree_node
		elseif node.parent == "." then
			path = node.name
		else
			path = node.parent .. "/" .. node.name
		end

		tree_node.path = path
		by_path[path] = tree_node
	end

	for _, node in ipairs(nodes) do
		if node.parent == "." and root ~= nil then
			local child = by_path[node.name]
			child.parent = root
			table.insert(root.children, child)
		elseif node.parent ~= "" then
			local child_path = node.parent .. "/" .. node.name
			local parent_path = node.parent

			local child = by_path[child_path]
			local parent = by_path[parent_path]

			if child and parent then
				child.parent = parent
				table.insert(parent.children, child)
			end
		end
	end

	return root
end

local function draw_tree(node, lines, nodes, highlights, depth, prefix, is_last)
	lines = lines or {}
	nodes = nodes or {}
	highlights = highlights or {}
	depth = depth or 0
	prefix = prefix or ""
	is_last = is_last == nil and true or is_last

	local icon = icons.get_icon(node.type)
	local connector = depth == 0 and "" or (is_last and "└─ " or "├─ ")
	local script_indicator = node.has_script and " " or ""
	local line = prefix .. connector .. icon .. " " .. node.name .. script_indicator
	local line_idx = #lines

	table.insert(lines, line)
	table.insert(nodes, node)

	local connector_start = #prefix
	table.insert(
		highlights,
		{ line = line_idx, col_start = connector_start, col_end = connector_start + #connector, group = "Comment" }
	)
	table.insert(highlights, { line = line_idx, col_start = 0, col_end = #prefix, group = "Comment" })

	local icon_start = #prefix + #connector
	table.insert(
		highlights,
		{ line = line_idx, col_start = icon_start, col_end = icon_start + #icon, group = "Function" }
	)

	local name_start = icon_start + #icon + 1
	table.insert(
		highlights,
		{ line = line_idx, col_start = name_start, col_end = name_start + #node.name, group = "Identifier" }
	)

	if node.has_script then
		local script_start = name_start + #node.name + 1
		table.insert(
			highlights,
			{ line = line_idx, col_start = script_start, col_end = script_start + 3, group = "DiagnosticOk" }
		)
	end

	local child_prefix = prefix .. (depth == 0 and "" or (is_last and "   " or "│  "))
	for i, child in ipairs(node.children) do
		draw_tree(child, lines, nodes, highlights, depth + 1, child_prefix, i == #node.children)
	end

	return lines, nodes, highlights
end

function M.render(scene)
	local root = build_tree(scene)
	local lines, nodes, highlights = draw_tree(root)

	return lines, nodes, highlights
end

return M
