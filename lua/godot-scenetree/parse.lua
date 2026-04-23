local M = {}

function M.parse_scene(path)
	local scene_tree = {}

	local scene = vim.fn.readfile(path)
	for i, line in ipairs(scene) do
		if vim.startswith(line, "[node") then
			local node = {}

			local name_pos = string.find(line, 'name="')
			if name_pos then
				local start_pos = name_pos + 6
				local end_pos = string.find(line, '"', start_pos) - 1
				node.name = string.sub(line, start_pos, end_pos)
			end

			local type_pos = string.find(line, 'type="')
			if type_pos then
				local start_pos = type_pos + 6
				local end_pos = string.find(line, '"', start_pos) - 1
				node.type = string.sub(line, start_pos, end_pos)
			else
				node.type = ""
			end

			local parent_pos = string.find(line, 'parent="')
			if parent_pos then
				local start_pos = parent_pos + 8
				local end_pos = string.find(line, '"', start_pos) - 1
				node.parent = string.sub(line, start_pos, end_pos)
			else
				node.parent = ""
			end

			for j = i + 1, #scene, 1 do
				if vim.startswith(scene[j], "script") then
					node.has_script = true
					break
				end
				if vim.startswith(scene[j], "[") then
					break
				end
			end

			table.insert(scene_tree, node)
		end
	end

	return scene_tree
end

return M
