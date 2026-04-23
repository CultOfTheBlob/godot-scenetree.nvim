local M = {}

local inherits = require("godot-scenetree.inherits")
local utils = require("godot-scenetree.utils")

local signals = {
	["AcceptDialog"] = {
		{
			name = "canceled",
			params = {},
		},
		{
			name = "confirmed",
			params = {},
		},
		{
			name = "custom_action",
			params = {
				{ name = "action", type = "StringName" },
			},
		},
	},
	["AnimatedSprite2D"] = {
		{
			name = "animation_changed",
			params = {},
		},
		{
			name = "animation_finished",
			params = {},
		},
		{
			name = "animation_looped",
			params = {},
		},
		{
			name = "frame_changed",
			params = {},
		},
		{
			name = "sprite_frames_changed",
			params = {},
		},
	},
	["AnimatedSprite3D"] = {
		{
			name = "animation_changed",
			params = {},
		},
		{
			name = "animation_finished",
			params = {},
		},
		{
			name = "animation_looped",
			params = {},
		},
		{
			name = "frame_changed",
			params = {},
		},
		{
			name = "sprite_frames_changed",
			params = {},
		},
	},
	["AnimationLibrary"] = {
		{
			name = "animation_added",
			params = {
				{ name = "name", type = "StringName" },
			},
		},
		{
			name = "animation_changed",
			params = {
				{ name = "name", type = "StringName" },
			},
		},
		{
			name = "animation_removed",
			params = {
				{ name = "name", type = "StringName" },
			},
		},
		{
			name = "animation_renamed",
			params = {
				{ name = "name", type = "StringName" },
				{ name = "to_name", type = "StringName" },
			},
		},
	},
	["AnimationMixer"] = {
		{
			name = "animation_finished",
			params = {
				{ name = "anim_name", type = "StringName" },
			},
		},
		{
			name = "animation_libraries_updated",
			params = {},
		},
		{
			name = "animation_list_changed",
			params = {},
		},
		{
			name = "animation_started",
			params = {
				{ name = "anim_name", type = "StringName" },
			},
		},
		{
			name = "caches_cleared",
			params = {},
		},
		{
			name = "mixer_applied",
			params = {},
		},
		{
			name = "mixer_updated",
			params = {},
		},
	},
	["AnimationNode"] = {
		{
			name = "animation_node_removed",
			params = {
				{ name = "object_id", type = "int" },
				{ name = "name", type = "String" },
			},
		},
		{
			name = "animation_node_renamed",
			params = {
				{ name = "object_id", type = "int" },
				{ name = "old_name", type = "String" },
				{ name = "new_name", type = "String" },
			},
		},
		{
			name = "node_updated",
			params = {
				{ name = "object_id", type = "int" },
			},
		},
		{
			name = "tree_changed",
			params = {},
		},
	},
	["AnimationNodeBlendSpace2D"] = {
		{
			name = "triangles_updated",
			params = {},
		},
	},
	["AnimationNodeBlendTree"] = {
		{
			name = "node_changed",
			params = {
				{ name = "node_name", type = "StringName" },
			},
		},
	},
	["AnimationNodeStateMachinePlayback"] = {
		{
			name = "state_finished",
			params = {
				{ name = "state", type = "StringName" },
			},
		},
		{
			name = "state_started",
			params = {
				{ name = "state", type = "StringName" },
			},
		},
	},
	["AnimationNodeStateMachineTransition"] = {
		{
			name = "advance_condition_changed",
			params = {},
		},
	},
	["AnimationPlayer"] = {
		{
			name = "animation_changed",
			params = {
				{ name = "old_name", type = "StringName" },
				{ name = "new_name", type = "StringName" },
			},
		},
		{
			name = "current_animation_changed",
			params = {
				{ name = "name", type = "StringName" },
			},
		},
	},
	["AnimationTree"] = {
		{
			name = "animation_player_changed",
			params = {},
		},
	},
	["Area2D"] = {
		{
			name = "area_entered",
			params = {
				{ name = "area", type = "Area2D" },
			},
		},
		{
			name = "area_exited",
			params = {
				{ name = "area", type = "Area2D" },
			},
		},
		{
			name = "area_shape_entered",
			params = {
				{ name = "area_rid", type = "RID" },
				{ name = "area", type = "Area2D" },
				{ name = "area_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "area_shape_exited",
			params = {
				{ name = "area_rid", type = "RID" },
				{ name = "area", type = "Area2D" },
				{ name = "area_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "body_entered",
			params = {
				{ name = "body", type = "Node2D" },
			},
		},
		{
			name = "body_exited",
			params = {
				{ name = "body", type = "Node2D" },
			},
		},
		{
			name = "body_shape_entered",
			params = {
				{ name = "body_rid", type = "RID" },
				{ name = "body", type = "Node2D" },
				{ name = "body_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "body_shape_exited",
			params = {
				{ name = "body_rid", type = "RID" },
				{ name = "body", type = "Node2D" },
				{ name = "body_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
	},
	["Area3D"] = {
		{
			name = "area_entered",
			params = {
				{ name = "area", type = "Area3D" },
			},
		},
		{
			name = "area_exited",
			params = {
				{ name = "area", type = "Area3D" },
			},
		},
		{
			name = "area_shape_entered",
			params = {
				{ name = "area_rid", type = "RID" },
				{ name = "area", type = "Area3D" },
				{ name = "area_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "area_shape_exited",
			params = {
				{ name = "area_rid", type = "RID" },
				{ name = "area", type = "Area3D" },
				{ name = "area_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "body_entered",
			params = {
				{ name = "body", type = "Node3D" },
			},
		},
		{
			name = "body_exited",
			params = {
				{ name = "body", type = "Node3D" },
			},
		},
		{
			name = "body_shape_entered",
			params = {
				{ name = "body_rid", type = "RID" },
				{ name = "body", type = "Node3D" },
				{ name = "body_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "body_shape_exited",
			params = {
				{ name = "body_rid", type = "RID" },
				{ name = "body", type = "Node3D" },
				{ name = "body_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
	},
	["AudioServer"] = {
		{
			name = "bus_layout_changed",
			params = {},
		},
		{
			name = "bus_renamed",
			params = {
				{ name = "bus_index", type = "int" },
				{ name = "old_name", type = "StringName" },
				{ name = "new_name", type = "StringName" },
			},
		},
	},
	["AudioStream"] = {
		{
			name = "parameter_list_changed",
			params = {},
		},
	},
	["AudioStreamPlayer"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["AudioStreamPlayer2D"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["AudioStreamPlayer3D"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["BaseButton"] = {
		{
			name = "button_down",
			params = {},
		},
		{
			name = "button_up",
			params = {},
		},
		{
			name = "pressed",
			params = {},
		},
		{
			name = "toggled",
			params = {
				{ name = "toggled_on", type = "bool" },
			},
		},
	},
	["BoneMap"] = {
		{
			name = "bone_map_updated",
			params = {},
		},
		{
			name = "profile_updated",
			params = {},
		},
	},
	["ButtonGroup"] = {
		{
			name = "pressed",
			params = {
				{ name = "button", type = "BaseButton" },
			},
		},
	},
	["CPUParticles2D"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["CPUParticles3D"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["CameraFeed"] = {
		{
			name = "format_changed",
			params = {},
		},
		{
			name = "frame_changed",
			params = {},
		},
	},
	["CameraServer"] = {
		{
			name = "camera_feed_added",
			params = {
				{ name = "id", type = "int" },
			},
		},
		{
			name = "camera_feed_removed",
			params = {
				{ name = "id", type = "int" },
			},
		},
		{
			name = "camera_feeds_updated",
			params = {},
		},
	},
	["CanvasItem"] = {
		{
			name = "draw",
			params = {},
		},
		{
			name = "hidden",
			params = {},
		},
		{
			name = "item_rect_changed",
			params = {},
		},
		{
			name = "visibility_changed",
			params = {},
		},
	},
	["CanvasLayer"] = {
		{
			name = "visibility_changed",
			params = {},
		},
	},
	["CodeEdit"] = {
		{
			name = "breakpoint_toggled",
			params = {
				{ name = "line", type = "int" },
			},
		},
		{
			name = "code_completion_requested",
			params = {},
		},
		{
			name = "symbol_hovered",
			params = {
				{ name = "symbol", type = "String" },
				{ name = "line", type = "int" },
				{ name = "column", type = "int" },
			},
		},
		{
			name = "symbol_lookup",
			params = {
				{ name = "symbol", type = "String" },
				{ name = "line", type = "int" },
				{ name = "column", type = "int" },
			},
		},
		{
			name = "symbol_validate",
			params = {
				{ name = "symbol", type = "String" },
			},
		},
	},
	["CollisionObject2D"] = {
		{
			name = "input_event",
			params = {
				{ name = "viewport", type = "Node" },
				{ name = "event", type = "InputEvent" },
				{ name = "shape_idx", type = "int" },
			},
		},
		{
			name = "mouse_entered",
			params = {},
		},
		{
			name = "mouse_exited",
			params = {},
		},
		{
			name = "mouse_shape_entered",
			params = {
				{ name = "shape_idx", type = "int" },
			},
		},
		{
			name = "mouse_shape_exited",
			params = {
				{ name = "shape_idx", type = "int" },
			},
		},
	},
	["CollisionObject3D"] = {
		{
			name = "input_event",
			params = {
				{ name = "camera", type = "Node" },
				{ name = "event", type = "InputEvent" },
				{ name = "event_position", type = "Vector3" },
				{ name = "normal", type = "Vector3" },
				{ name = "shape_idx", type = "int" },
			},
		},
		{
			name = "mouse_entered",
			params = {},
		},
		{
			name = "mouse_exited",
			params = {},
		},
	},
	["ColorPicker"] = {
		{
			name = "color_changed",
			params = {
				{ name = "color", type = "Color" },
			},
		},
		{
			name = "preset_added",
			params = {
				{ name = "color", type = "Color" },
			},
		},
		{
			name = "preset_removed",
			params = {
				{ name = "color", type = "Color" },
			},
		},
	},
	["ColorPickerButton"] = {
		{
			name = "color_changed",
			params = {
				{ name = "color", type = "Color" },
			},
		},
		{
			name = "picker_created",
			params = {},
		},
		{
			name = "popup_closed",
			params = {},
		},
	},
	["Container"] = {
		{
			name = "pre_sort_children",
			params = {},
		},
		{
			name = "sort_children",
			params = {},
		},
	},
	["Control"] = {
		{
			name = "focus_entered",
			params = {},
		},
		{
			name = "focus_exited",
			params = {},
		},
		{
			name = "gui_input",
			params = {
				{ name = "event", type = "InputEvent" },
			},
		},
		{
			name = "maximum_size_changed",
			params = {},
		},
		{
			name = "minimum_size_changed",
			params = {},
		},
		{
			name = "mouse_entered",
			params = {},
		},
		{
			name = "mouse_exited",
			params = {},
		},
		{
			name = "resized",
			params = {},
		},
		{
			name = "size_flags_changed",
			params = {},
		},
		{
			name = "theme_changed",
			params = {},
		},
	},
	["Curve"] = {
		{
			name = "domain_changed",
			params = {},
		},
		{
			name = "range_changed",
			params = {},
		},
	},
	["DisplayServer"] = {
		{
			name = "orientation_changed",
			params = {
				{ name = "orientation", type = "int" },
			},
		},
	},
	["EditorDebuggerSession"] = {
		{
			name = "breaked",
			params = {
				{ name = "can_debug", type = "bool" },
			},
		},
		{
			name = "continued",
			params = {},
		},
		{
			name = "started",
			params = {},
		},
		{
			name = "stopped",
			params = {},
		},
	},
	["EditorDock"] = {
		{
			name = "closed",
			params = {},
		},
		{
			name = "opened",
			params = {},
		},
	},
	["EditorFileSystem"] = {
		{
			name = "filesystem_changed",
			params = {},
		},
		{
			name = "resources_reimported",
			params = {
				{ name = "resources", type = "PackedStringArray" },
			},
		},
		{
			name = "resources_reimporting",
			params = {
				{ name = "resources", type = "PackedStringArray" },
			},
		},
		{
			name = "resources_reload",
			params = {
				{ name = "resources", type = "PackedStringArray" },
			},
		},
		{
			name = "script_classes_updated",
			params = {},
		},
		{
			name = "sources_changed",
			params = {
				{ name = "exist", type = "bool" },
			},
		},
	},
	["EditorInspector"] = {
		{
			name = "edited_object_changed",
			params = {},
		},
		{
			name = "object_id_selected",
			params = {
				{ name = "id", type = "int" },
			},
		},
		{
			name = "property_deleted",
			params = {
				{ name = "property", type = "String" },
			},
		},
		{
			name = "property_edited",
			params = {
				{ name = "property", type = "String" },
			},
		},
		{
			name = "property_keyed",
			params = {
				{ name = "property", type = "String" },
				{ name = "value", type = "Variant" },
				{ name = "advance", type = "bool" },
			},
		},
		{
			name = "property_selected",
			params = {
				{ name = "property", type = "String" },
			},
		},
		{
			name = "property_toggled",
			params = {
				{ name = "property", type = "String" },
				{ name = "checked", type = "bool" },
			},
		},
		{
			name = "resource_selected",
			params = {
				{ name = "resource", type = "Resource" },
				{ name = "path", type = "String" },
			},
		},
		{
			name = "restart_requested",
			params = {},
		},
	},
	["EditorPlugin"] = {
		{
			name = "main_screen_changed",
			params = {
				{ name = "screen_name", type = "String" },
			},
		},
		{
			name = "project_settings_changed",
			params = {},
		},
		{
			name = "resource_saved",
			params = {
				{ name = "resource", type = "Resource" },
			},
		},
		{
			name = "scene_changed",
			params = {
				{ name = "scene_root", type = "Node" },
			},
		},
		{
			name = "scene_closed",
			params = {
				{ name = "filepath", type = "String" },
			},
		},
		{
			name = "scene_saved",
			params = {
				{ name = "filepath", type = "String" },
			},
		},
	},
	["EditorProperty"] = {
		{
			name = "multiple_properties_changed",
			params = {
				{ name = "properties", type = "PackedStringArray" },
				{ name = "value", type = "Array" },
			},
		},
		{
			name = "object_id_selected",
			params = {
				{ name = "property", type = "StringName" },
				{ name = "id", type = "int" },
			},
		},
		{
			name = "property_can_revert_changed",
			params = {
				{ name = "property", type = "StringName" },
				{ name = "can_revert", type = "bool" },
			},
		},
		{
			name = "property_changed",
			params = {
				{ name = "property", type = "StringName" },
				{ name = "value", type = "Variant" },
				{ name = "field", type = "StringName" },
				{ name = "changing", type = "bool" },
			},
		},
		{
			name = "property_checked",
			params = {
				{ name = "property", type = "StringName" },
				{ name = "checked", type = "bool" },
			},
		},
		{
			name = "property_deleted",
			params = {
				{ name = "property", type = "StringName" },
			},
		},
		{
			name = "property_favorited",
			params = {
				{ name = "property", type = "StringName" },
				{ name = "favorited", type = "bool" },
			},
		},
		{
			name = "property_keyed",
			params = {
				{ name = "property", type = "StringName" },
			},
		},
		{
			name = "property_keyed_with_value",
			params = {
				{ name = "property", type = "StringName" },
				{ name = "value", type = "Variant" },
			},
		},
		{
			name = "property_overridden",
			params = {},
		},
		{
			name = "property_pinned",
			params = {
				{ name = "property", type = "StringName" },
				{ name = "pinned", type = "bool" },
			},
		},
		{
			name = "resource_selected",
			params = {
				{ name = "path", type = "String" },
				{ name = "resource", type = "Resource" },
			},
		},
		{
			name = "selected",
			params = {
				{ name = "path", type = "String" },
				{ name = "focusable_idx", type = "int" },
			},
		},
	},
	["EditorResourcePicker"] = {
		{
			name = "resource_changed",
			params = {
				{ name = "resource", type = "Resource" },
			},
		},
		{
			name = "resource_selected",
			params = {
				{ name = "resource", type = "Resource" },
				{ name = "inspect", type = "bool" },
			},
		},
	},
	["EditorResourcePreview"] = {
		{
			name = "preview_invalidated",
			params = {
				{ name = "path", type = "String" },
			},
		},
	},
	["EditorSelection"] = {
		{
			name = "selection_changed",
			params = {},
		},
	},
	["EditorSettings"] = {
		{
			name = "settings_changed",
			params = {},
		},
	},
	["EditorSpinSlider"] = {
		{
			name = "grabbed",
			params = {},
		},
		{
			name = "ungrabbed",
			params = {},
		},
		{
			name = "updown_pressed",
			params = {},
		},
		{
			name = "value_focus_entered",
			params = {},
		},
		{
			name = "value_focus_exited",
			params = {},
		},
	},
	["EditorUndoRedoManager"] = {
		{
			name = "history_changed",
			params = {},
		},
		{
			name = "version_changed",
			params = {},
		},
	},
	["FileDialog"] = {
		{
			name = "dir_selected",
			params = {
				{ name = "dir", type = "String" },
			},
		},
		{
			name = "file_selected",
			params = {
				{ name = "path", type = "String" },
			},
		},
		{
			name = "filename_filter_changed",
			params = {
				{ name = "filter", type = "String" },
			},
		},
		{
			name = "files_selected",
			params = {
				{ name = "paths", type = "PackedStringArray" },
			},
		},
	},
	["FileSystemDock"] = {
		{
			name = "display_mode_changed",
			params = {},
		},
		{
			name = "file_removed",
			params = {
				{ name = "file", type = "String" },
			},
		},
		{
			name = "files_moved",
			params = {
				{ name = "old_file", type = "String" },
				{ name = "new_file", type = "String" },
			},
		},
		{
			name = "folder_color_changed",
			params = {},
		},
		{
			name = "folder_moved",
			params = {
				{ name = "old_folder", type = "String" },
				{ name = "new_folder", type = "String" },
			},
		},
		{
			name = "folder_removed",
			params = {
				{ name = "folder", type = "String" },
			},
		},
		{
			name = "inherit",
			params = {
				{ name = "file", type = "String" },
			},
		},
		{
			name = "instantiate",
			params = {
				{ name = "files", type = "PackedStringArray" },
			},
		},
		{
			name = "resource_removed",
			params = {
				{ name = "resource", type = "Resource" },
			},
		},
		{
			name = "selection_changed",
			params = {},
		},
	},
	["FoldableContainer"] = {
		{
			name = "folding_changed",
			params = {
				{ name = "is_folded", type = "bool" },
			},
		},
	},
	["FoldableGroup"] = {
		{
			name = "expanded",
			params = {
				{ name = "container", type = "FoldableContainer" },
			},
		},
	},
	["GDExtensionManager"] = {
		{
			name = "extension_loaded",
			params = {
				{ name = "extension", type = "GDExtension" },
			},
		},
		{
			name = "extension_unloading",
			params = {
				{ name = "extension", type = "GDExtension" },
			},
		},
		{
			name = "extensions_reloaded",
			params = {},
		},
	},
	["GPUParticles2D"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["GPUParticles3D"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["GraphEdit"] = {
		{
			name = "begin_node_move",
			params = {},
		},
		{
			name = "connection_drag_ended",
			params = {},
		},
		{
			name = "connection_drag_started",
			params = {
				{ name = "from_node", type = "StringName" },
				{ name = "from_port", type = "int" },
				{ name = "is_output", type = "bool" },
			},
		},
		{
			name = "connection_from_empty",
			params = {
				{ name = "to_node", type = "StringName" },
				{ name = "to_port", type = "int" },
				{ name = "release_position", type = "Vector2" },
			},
		},
		{
			name = "connection_request",
			params = {
				{ name = "from_node", type = "StringName" },
				{ name = "from_port", type = "int" },
				{ name = "to_node", type = "StringName" },
				{ name = "to_port", type = "int" },
			},
		},
		{
			name = "connection_to_empty",
			params = {
				{ name = "from_node", type = "StringName" },
				{ name = "from_port", type = "int" },
				{ name = "release_position", type = "Vector2" },
			},
		},
		{
			name = "copy_nodes_request",
			params = {},
		},
		{
			name = "cut_nodes_request",
			params = {},
		},
		{
			name = "delete_nodes_request",
			params = {
				{ name = "nodes", type = "StringName[]" },
			},
		},
		{
			name = "disconnection_request",
			params = {
				{ name = "from_node", type = "StringName" },
				{ name = "from_port", type = "int" },
				{ name = "to_node", type = "StringName" },
				{ name = "to_port", type = "int" },
			},
		},
		{
			name = "duplicate_nodes_request",
			params = {},
		},
		{
			name = "end_node_move",
			params = {},
		},
		{
			name = "frame_rect_changed",
			params = {
				{ name = "frame", type = "GraphFrame" },
				{ name = "new_rect", type = "Rect2" },
			},
		},
		{
			name = "graph_elements_linked_to_frame_request",
			params = {
				{ name = "elements", type = "Array" },
				{ name = "frame", type = "StringName" },
			},
		},
		{
			name = "node_deselected",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "node_selected",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "paste_nodes_request",
			params = {},
		},
		{
			name = "popup_request",
			params = {
				{ name = "at_position", type = "Vector2" },
			},
		},
		{
			name = "scroll_offset_changed",
			params = {
				{ name = "offset", type = "Vector2" },
			},
		},
	},
	["GraphElement"] = {
		{
			name = "delete_request",
			params = {},
		},
		{
			name = "dragged",
			params = {
				{ name = "from", type = "Vector2" },
				{ name = "to", type = "Vector2" },
			},
		},
		{
			name = "node_deselected",
			params = {},
		},
		{
			name = "node_selected",
			params = {},
		},
		{
			name = "position_offset_changed",
			params = {},
		},
		{
			name = "raise_request",
			params = {},
		},
		{
			name = "resize_end",
			params = {
				{ name = "new_size", type = "Vector2" },
			},
		},
		{
			name = "resize_request",
			params = {
				{ name = "new_size", type = "Vector2" },
			},
		},
	},
	["GraphFrame"] = {
		{
			name = "autoshrink_changed",
			params = {},
		},
	},
	["GraphNode"] = {
		{
			name = "slot_sizes_changed",
			params = {},
		},
		{
			name = "slot_updated",
			params = {
				{ name = "slot_index", type = "int" },
			},
		},
	},
	["HTTPRequest"] = {
		{
			name = "request_completed",
			params = {
				{ name = "result", type = "int" },
				{ name = "response_code", type = "int" },
				{ name = "headers", type = "PackedStringArray" },
				{ name = "body", type = "PackedByteArray" },
			},
		},
	},
	["Input"] = {
		{
			name = "joy_connection_changed",
			params = {
				{ name = "device", type = "int" },
				{ name = "connected", type = "bool" },
			},
		},
	},
	["InputMap"] = {
		{
			name = "project_settings_loaded",
			params = {},
		},
	},
	["ItemList"] = {
		{
			name = "empty_clicked",
			params = {
				{ name = "at_position", type = "Vector2" },
				{ name = "mouse_button_index", type = "int" },
			},
		},
		{
			name = "item_activated",
			params = {
				{ name = "index", type = "int" },
			},
		},
		{
			name = "item_clicked",
			params = {
				{ name = "index", type = "int" },
				{ name = "at_position", type = "Vector2" },
				{ name = "mouse_button_index", type = "int" },
			},
		},
		{
			name = "item_selected",
			params = {
				{ name = "index", type = "int" },
			},
		},
		{
			name = "multi_selected",
			params = {
				{ name = "index", type = "int" },
				{ name = "selected", type = "bool" },
			},
		},
	},
	["JavaScriptBridge"] = {
		{
			name = "pwa_update_available",
			params = {},
		},
	},
	["LineEdit"] = {
		{
			name = "editing_toggled",
			params = {
				{ name = "toggled_on", type = "bool" },
			},
		},
		{
			name = "text_change_rejected",
			params = {
				{ name = "rejected_substring", type = "String" },
			},
		},
		{
			name = "text_changed",
			params = {
				{ name = "new_text", type = "String" },
			},
		},
		{
			name = "text_submitted",
			params = {
				{ name = "new_text", type = "String" },
			},
		},
	},
	["MainLoop"] = {
		{
			name = "on_request_permissions_result",
			params = {
				{ name = "permission", type = "String" },
				{ name = "granted", type = "bool" },
			},
		},
	},
	["MenuButton"] = {
		{
			name = "about_to_popup",
			params = {},
		},
	},
	["MeshInstance2D"] = {
		{
			name = "texture_changed",
			params = {},
		},
	},
	["MultiMeshInstance2D"] = {
		{
			name = "texture_changed",
			params = {},
		},
	},
	["MultiplayerAPI"] = {
		{
			name = "connected_to_server",
			params = {},
		},
		{
			name = "connection_failed",
			params = {},
		},
		{
			name = "peer_connected",
			params = {
				{ name = "id", type = "int" },
			},
		},
		{
			name = "peer_disconnected",
			params = {
				{ name = "id", type = "int" },
			},
		},
		{
			name = "server_disconnected",
			params = {},
		},
	},
	["MultiplayerPeer"] = {
		{
			name = "peer_connected",
			params = {
				{ name = "id", type = "int" },
			},
		},
		{
			name = "peer_disconnected",
			params = {
				{ name = "id", type = "int" },
			},
		},
	},
	["NavigationAgent2D"] = {
		{
			name = "link_reached",
			params = {
				{ name = "details", type = "Dictionary" },
			},
		},
		{
			name = "navigation_finished",
			params = {},
		},
		{
			name = "path_changed",
			params = {},
		},
		{
			name = "target_reached",
			params = {},
		},
		{
			name = "velocity_computed",
			params = {
				{ name = "safe_velocity", type = "Vector2" },
			},
		},
		{
			name = "waypoint_reached",
			params = {
				{ name = "details", type = "Dictionary" },
			},
		},
	},
	["NavigationAgent3D"] = {
		{
			name = "link_reached",
			params = {
				{ name = "details", type = "Dictionary" },
			},
		},
		{
			name = "navigation_finished",
			params = {},
		},
		{
			name = "path_changed",
			params = {},
		},
		{
			name = "target_reached",
			params = {},
		},
		{
			name = "velocity_computed",
			params = {
				{ name = "safe_velocity", type = "Vector3" },
			},
		},
		{
			name = "waypoint_reached",
			params = {
				{ name = "details", type = "Dictionary" },
			},
		},
	},
	["NavigationRegion2D"] = {
		{
			name = "bake_finished",
			params = {},
		},
		{
			name = "navigation_polygon_changed",
			params = {},
		},
	},
	["NavigationRegion3D"] = {
		{
			name = "bake_finished",
			params = {},
		},
		{
			name = "navigation_mesh_changed",
			params = {},
		},
	},
	["NavigationServer2D"] = {
		{
			name = "avoidance_debug_changed",
			params = {},
		},
		{
			name = "map_changed",
			params = {
				{ name = "map", type = "RID" },
			},
		},
		{
			name = "navigation_debug_changed",
			params = {},
		},
	},
	["NavigationServer3D"] = {
		{
			name = "avoidance_debug_changed",
			params = {},
		},
		{
			name = "map_changed",
			params = {
				{ name = "map", type = "RID" },
			},
		},
		{
			name = "navigation_debug_changed",
			params = {},
		},
	},
	["NinePatchRect"] = {
		{
			name = "texture_changed",
			params = {},
		},
	},
	["Node"] = {
		{
			name = "child_entered_tree",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "child_exiting_tree",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "child_order_changed",
			params = {},
		},
		{
			name = "editor_description_changed",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "editor_state_changed",
			params = {},
		},
		{
			name = "ready",
			params = {},
		},
		{
			name = "renamed",
			params = {},
		},
		{
			name = "replacing_by",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "tree_entered",
			params = {},
		},
		{
			name = "tree_exited",
			params = {},
		},
		{
			name = "tree_exiting",
			params = {},
		},
	},
	["Node3D"] = {
		{
			name = "visibility_changed",
			params = {},
		},
	},
	["Object"] = {
		{
			name = "property_list_changed",
			params = {},
		},
		{
			name = "script_changed",
			params = {},
		},
	},
	["OptionButton"] = {
		{
			name = "item_focused",
			params = {
				{ name = "index", type = "int" },
			},
		},
		{
			name = "item_selected",
			params = {
				{ name = "index", type = "int" },
			},
		},
	},
	["ParticleProcessMaterial"] = {
		{
			name = "emission_shape_changed",
			params = {},
		},
	},
	["Path3D"] = {
		{
			name = "curve_changed",
			params = {},
		},
		{
			name = "debug_color_changed",
			params = {},
		},
	},
	["Popup"] = {
		{
			name = "popup_hide",
			params = {},
		},
	},
	["PopupMenu"] = {
		{
			name = "id_focused",
			params = {
				{ name = "id", type = "int" },
			},
		},
		{
			name = "id_pressed",
			params = {
				{ name = "id", type = "int" },
			},
		},
		{
			name = "index_pressed",
			params = {
				{ name = "index", type = "int" },
			},
		},
		{
			name = "menu_changed",
			params = {},
		},
	},
	["ProjectSettings"] = {
		{
			name = "settings_changed",
			params = {},
		},
	},
	["Range"] = {
		{
			name = "changed",
			params = {},
		},
		{
			name = "value_changed",
			params = {
				{ name = "value", type = "float" },
			},
		},
	},
	["RenderingServer"] = {
		{
			name = "frame_post_draw",
			params = {},
		},
		{
			name = "frame_pre_draw",
			params = {},
		},
	},
	["Resource"] = {
		{
			name = "changed",
			params = {},
		},
		{
			name = "setup_local_to_scene_requested",
			params = {},
		},
	},
	["RichTextLabel"] = {
		{
			name = "finished",
			params = {},
		},
		{
			name = "meta_clicked",
			params = {
				{ name = "meta", type = "Variant" },
			},
		},
		{
			name = "meta_hover_ended",
			params = {
				{ name = "meta", type = "Variant" },
			},
		},
		{
			name = "meta_hover_started",
			params = {
				{ name = "meta", type = "Variant" },
			},
		},
	},
	["RigidBody2D"] = {
		{
			name = "body_entered",
			params = {
				{ name = "body", type = "Node" },
			},
		},
		{
			name = "body_exited",
			params = {
				{ name = "body", type = "Node" },
			},
		},
		{
			name = "body_shape_entered",
			params = {
				{ name = "body_rid", type = "RID" },
				{ name = "body", type = "Node" },
				{ name = "body_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "body_shape_exited",
			params = {
				{ name = "body_rid", type = "RID" },
				{ name = "body", type = "Node" },
				{ name = "body_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "sleeping_state_changed",
			params = {},
		},
	},
	["RigidBody3D"] = {
		{
			name = "body_entered",
			params = {
				{ name = "body", type = "Node" },
			},
		},
		{
			name = "body_exited",
			params = {
				{ name = "body", type = "Node" },
			},
		},
		{
			name = "body_shape_entered",
			params = {
				{ name = "body_rid", type = "RID" },
				{ name = "body", type = "Node" },
				{ name = "body_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "body_shape_exited",
			params = {
				{ name = "body_rid", type = "RID" },
				{ name = "body", type = "Node" },
				{ name = "body_shape_index", type = "int" },
				{ name = "local_shape_index", type = "int" },
			},
		},
		{
			name = "sleeping_state_changed",
			params = {},
		},
	},
	["SceneTree"] = {
		{
			name = "node_added",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "node_configuration_warning_changed",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "node_removed",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "node_renamed",
			params = {
				{ name = "node", type = "Node" },
			},
		},
		{
			name = "physics_frame",
			params = {},
		},
		{
			name = "process_frame",
			params = {},
		},
		{
			name = "scene_changed",
			params = {},
		},
		{
			name = "tree_changed",
			params = {},
		},
		{
			name = "tree_process_mode_changed",
			params = {},
		},
	},
	["SceneTreeTimer"] = {
		{
			name = "timeout",
			params = {},
		},
	},
	["ScriptCreateDialog"] = {
		{
			name = "script_created",
			params = {
				{ name = "script", type = "Script" },
			},
		},
	},
	["ScriptEditor"] = {
		{
			name = "editor_script_changed",
			params = {
				{ name = "script", type = "Script" },
			},
		},
		{
			name = "script_close",
			params = {
				{ name = "script", type = "Script" },
			},
		},
	},
	["ScriptEditorBase"] = {
		{
			name = "edited_script_changed",
			params = {},
		},
		{
			name = "go_to_help",
			params = {
				{ name = "what", type = "String" },
			},
		},
		{
			name = "go_to_method",
			params = {
				{ name = "script", type = "Object" },
				{ name = "method", type = "String" },
			},
		},
		{
			name = "name_changed",
			params = {},
		},
		{
			name = "replace_in_files_requested",
			params = {
				{ name = "text", type = "String" },
			},
		},
		{
			name = "request_help",
			params = {
				{ name = "topic", type = "String" },
			},
		},
		{
			name = "request_open_script_at_line",
			params = {
				{ name = "script", type = "Object" },
				{ name = "line", type = "int" },
			},
		},
		{
			name = "request_save_history",
			params = {},
		},
		{
			name = "request_save_previous_state",
			params = {
				{ name = "state", type = "Dictionary" },
			},
		},
		{
			name = "search_in_files_requested",
			params = {
				{ name = "text", type = "String" },
			},
		},
	},
	["ScrollBar"] = {
		{
			name = "scrolling",
			params = {},
		},
	},
	["ScrollContainer"] = {
		{
			name = "scroll_ended",
			params = {},
		},
		{
			name = "scroll_started",
			params = {},
		},
	},
	["Skeleton2D"] = {
		{
			name = "bone_setup_changed",
			params = {},
		},
	},
	["Skeleton3D"] = {
		{
			name = "bone_enabled_changed",
			params = {
				{ name = "bone_idx", type = "int" },
			},
		},
		{
			name = "bone_list_changed",
			params = {},
		},
		{
			name = "pose_updated",
			params = {},
		},
		{
			name = "rest_updated",
			params = {},
		},
		{
			name = "show_rest_only_changed",
			params = {},
		},
		{
			name = "skeleton_updated",
			params = {},
		},
	},
	["SkeletonModifier3D"] = {
		{
			name = "modification_processed",
			params = {},
		},
	},
	["SkeletonProfile"] = {
		{
			name = "profile_updated",
			params = {},
		},
	},
	["Slider"] = {
		{
			name = "drag_ended",
			params = {
				{ name = "value_changed", type = "bool" },
			},
		},
		{
			name = "drag_started",
			params = {},
		},
	},
	["SplitContainer"] = {
		{
			name = "drag_ended",
			params = {},
		},
		{
			name = "drag_started",
			params = {},
		},
		{
			name = "dragged",
			params = {
				{ name = "offset", type = "int" },
			},
		},
	},
	["Sprite2D"] = {
		{
			name = "frame_changed",
			params = {},
		},
		{
			name = "texture_changed",
			params = {},
		},
	},
	["Sprite3D"] = {
		{
			name = "frame_changed",
			params = {},
		},
		{
			name = "texture_changed",
			params = {},
		},
	},
	["StatusIndicator"] = {
		{
			name = "pressed",
			params = {
				{ name = "mouse_button", type = "int" },
				{ name = "mouse_position", type = "Vector2i" },
			},
		},
	},
	["TabBar"] = {
		{
			name = "active_tab_rearranged",
			params = {
				{ name = "idx_to", type = "int" },
			},
		},
		{
			name = "tab_button_pressed",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_changed",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_clicked",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_close_pressed",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_hovered",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_rmb_clicked",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_selected",
			params = {
				{ name = "tab", type = "int" },
			},
		},
	},
	["TabContainer"] = {
		{
			name = "active_tab_rearranged",
			params = {
				{ name = "idx_to", type = "int" },
			},
		},
		{
			name = "pre_popup_pressed",
			params = {},
		},
		{
			name = "tab_button_pressed",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_changed",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_clicked",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_hovered",
			params = {
				{ name = "tab", type = "int" },
			},
		},
		{
			name = "tab_selected",
			params = {
				{ name = "tab", type = "int" },
			},
		},
	},
	["TextEdit"] = {
		{
			name = "caret_changed",
			params = {},
		},
		{
			name = "gutter_added",
			params = {},
		},
		{
			name = "gutter_clicked",
			params = {
				{ name = "line", type = "int" },
				{ name = "gutter", type = "int" },
			},
		},
		{
			name = "gutter_removed",
			params = {},
		},
		{
			name = "lines_edited_from",
			params = {
				{ name = "from_line", type = "int" },
				{ name = "to_line", type = "int" },
			},
		},
		{
			name = "text_changed",
			params = {},
		},
		{
			name = "text_set",
			params = {},
		},
	},
	["TextServerManager"] = {
		{
			name = "interface_added",
			params = {
				{ name = "interface_name", type = "StringName" },
			},
		},
		{
			name = "interface_removed",
			params = {
				{ name = "interface_name", type = "StringName" },
			},
		},
	},
	["ThemeDB"] = {
		{
			name = "fallback_changed",
			params = {},
		},
	},
	["TileData"] = {
		{
			name = "changed",
			params = {},
		},
	},
	["TileMap"] = {
		{
			name = "changed",
			params = {},
		},
	},
	["TileMapLayer"] = {
		{
			name = "changed",
			params = {},
		},
	},
	["Timer"] = {
		{
			name = "timeout",
			params = {},
		},
	},
	["TouchScreenButton"] = {
		{
			name = "pressed",
			params = {},
		},
		{
			name = "released",
			params = {},
		},
	},
	["Tree"] = {
		{
			name = "button_clicked",
			params = {
				{ name = "item", type = "TreeItem" },
				{ name = "column", type = "int" },
				{ name = "id", type = "int" },
				{ name = "mouse_button_index", type = "int" },
			},
		},
		{
			name = "cell_selected",
			params = {},
		},
		{
			name = "check_propagated_to_item",
			params = {
				{ name = "item", type = "TreeItem" },
				{ name = "column", type = "int" },
			},
		},
		{
			name = "column_title_clicked",
			params = {
				{ name = "column", type = "int" },
				{ name = "mouse_button_index", type = "int" },
			},
		},
		{
			name = "custom_item_clicked",
			params = {
				{ name = "mouse_button_index", type = "int" },
			},
		},
		{
			name = "custom_popup_edited",
			params = {
				{ name = "arrow_clicked", type = "bool" },
			},
		},
		{
			name = "empty_clicked",
			params = {
				{ name = "click_position", type = "Vector2" },
				{ name = "mouse_button_index", type = "int" },
			},
		},
		{
			name = "item_activated",
			params = {},
		},
		{
			name = "item_collapsed",
			params = {
				{ name = "item", type = "TreeItem" },
			},
		},
		{
			name = "item_edited",
			params = {},
		},
		{
			name = "item_icon_double_clicked",
			params = {},
		},
		{
			name = "item_mouse_selected",
			params = {
				{ name = "mouse_position", type = "Vector2" },
				{ name = "mouse_button_index", type = "int" },
			},
		},
		{
			name = "item_selected",
			params = {},
		},
		{
			name = "multi_selected",
			params = {
				{ name = "item", type = "TreeItem" },
				{ name = "column", type = "int" },
				{ name = "selected", type = "bool" },
			},
		},
		{
			name = "nothing_selected",
			params = {},
		},
	},
	["Tween"] = {
		{
			name = "finished",
			params = {},
		},
		{
			name = "loop_finished",
			params = {
				{ name = "loop_count", type = "int" },
			},
		},
		{
			name = "step_finished",
			params = {
				{ name = "idx", type = "int" },
			},
		},
	},
	["Tweener"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["UndoRedo"] = {
		{
			name = "version_changed",
			params = {},
		},
	},
	["VideoStreamPlayer"] = {
		{
			name = "finished",
			params = {},
		},
	},
	["Viewport"] = {
		{
			name = "gui_focus_changed",
			params = {
				{ name = "node", type = "Control" },
			},
		},
		{
			name = "size_changed",
			params = {},
		},
	},
	["VirtualJoystick"] = {
		{
			name = "flick_canceled",
			params = {},
		},
		{
			name = "flicked",
			params = {
				{ name = "input_vector", type = "Vector2" },
			},
		},
		{
			name = "pressed",
			params = {},
		},
		{
			name = "released",
			params = {
				{ name = "input_vector", type = "Vector2" },
			},
		},
		{
			name = "tapped",
			params = {},
		},
	},
	["VisibleOnScreenNotifier2D"] = {
		{
			name = "screen_entered",
			params = {},
		},
		{
			name = "screen_exited",
			params = {},
		},
	},
	["VisibleOnScreenNotifier3D"] = {
		{
			name = "screen_entered",
			params = {},
		},
		{
			name = "screen_exited",
			params = {},
		},
	},
	["Window"] = {
		{
			name = "about_to_popup",
			params = {},
		},
		{
			name = "close_requested",
			params = {},
		},
		{
			name = "dpi_changed",
			params = {},
		},
		{
			name = "files_dropped",
			params = {
				{ name = "files", type = "PackedStringArray" },
			},
		},
		{
			name = "focus_entered",
			params = {},
		},
		{
			name = "focus_exited",
			params = {},
		},
		{
			name = "go_back_requested",
			params = {},
		},
		{
			name = "mouse_entered",
			params = {},
		},
		{
			name = "mouse_exited",
			params = {},
		},
		{
			name = "nonclient_window_input",
			params = {
				{ name = "event", type = "InputEvent" },
			},
		},
		{
			name = "output_max_linear_value_changed",
			params = {
				{ name = "output_max_linear_value", type = "float" },
			},
		},
		{
			name = "theme_changed",
			params = {},
		},
		{
			name = "title_changed",
			params = {},
		},
		{
			name = "titlebar_changed",
			params = {},
		},
		{
			name = "visibility_changed",
			params = {},
		},
		{
			name = "window_input",
			params = {
				{ name = "event", type = "InputEvent" },
			},
		},
	},
	["XRController3D"] = {
		{
			name = "button_pressed",
			params = {
				{ name = "name", type = "String" },
			},
		},
		{
			name = "button_released",
			params = {
				{ name = "name", type = "String" },
			},
		},
		{
			name = "input_float_changed",
			params = {
				{ name = "name", type = "String" },
				{ name = "value", type = "float" },
			},
		},
		{
			name = "input_vector2_changed",
			params = {
				{ name = "name", type = "String" },
				{ name = "value", type = "Vector2" },
			},
		},
		{
			name = "profile_changed",
			params = {
				{ name = "role", type = "String" },
			},
		},
	},
	["XRInterface"] = {
		{
			name = "play_area_changed",
			params = {
				{ name = "mode", type = "int" },
			},
		},
	},
	["XRNode3D"] = {
		{
			name = "tracking_changed",
			params = {
				{ name = "tracking", type = "bool" },
			},
		},
	},
	["XRPositionalTracker"] = {
		{
			name = "button_pressed",
			params = {
				{ name = "name", type = "String" },
			},
		},
		{
			name = "button_released",
			params = {
				{ name = "name", type = "String" },
			},
		},
		{
			name = "input_float_changed",
			params = {
				{ name = "name", type = "String" },
				{ name = "value", type = "float" },
			},
		},
		{
			name = "input_vector2_changed",
			params = {
				{ name = "name", type = "String" },
				{ name = "vector", type = "Vector2" },
			},
		},
		{
			name = "pose_changed",
			params = {
				{ name = "pose", type = "XRPose" },
			},
		},
		{
			name = "pose_lost_tracking",
			params = {
				{ name = "pose", type = "XRPose" },
			},
		},
		{
			name = "profile_changed",
			params = {
				{ name = "role", type = "String" },
			},
		},
	},
	["XRServer"] = {
		{
			name = "interface_added",
			params = {
				{ name = "interface_name", type = "StringName" },
			},
		},
		{
			name = "interface_removed",
			params = {
				{ name = "interface_name", type = "StringName" },
			},
		},
		{
			name = "reference_frame_changed",
			params = {},
		},
		{
			name = "tracker_added",
			params = {
				{ name = "tracker_name", type = "StringName" },
				{ name = "type", type = "int" },
			},
		},
		{
			name = "tracker_removed",
			params = {
				{ name = "tracker_name", type = "StringName" },
				{ name = "type", type = "int" },
			},
		},
		{
			name = "tracker_updated",
			params = {
				{ name = "tracker_name", type = "StringName" },
				{ name = "type", type = "int" },
			},
		},
		{
			name = "world_origin_changed",
			params = {},
		},
	},
}

function M.get_signals(node_type)
	local result = {}
	local current = node_type
	while current do
		for _, sig in ipairs(signals[current] or {}) do
			table.insert(result, { signal = sig, from = current })
		end
		current = inherits[current]
	end
	return result
end

function M.to_string(node_signals, buf_type)
	local result = {}

	if buf_type == "cs" then
		for _, s in ipairs(node_signals) do
			local params = "("
			for i, p in ipairs(s.signal.params) do
				params = params .. p.type .. " " .. utils.camel_case(p.name)
				if i < #s.signal.params then
					params = params .. ", "
				end
			end
			params = params .. ")"
			table.insert(result, s.from .. ": " .. utils.pascal_case(s.signal.name) .. params)
		end

		return result
	end

	for _, s in ipairs(node_signals) do
		local params = "("
		for i, p in ipairs(s.signal.params) do
			params = params .. p.name .. ": " .. p.type
			if i < #s.signal.params then
				params = params .. ", "
			end
		end
		params = params .. ")"
		table.insert(result, s.from .. ": " .. s.signal.name .. params)
	end

	return result
end

function M.to_code(node_name, signal, buf_type)
	local signal_string = string.sub(signal, string.find(signal, ":") + 2)

	if buf_type == "cs" then
		return "public " .. "void " .. "On" .. node_name .. signal_string .. "\n{}"
	end

	return "func " .. "_on_" .. utils.snake_case(node_name) .. "_" .. signal_string .. " -> void:" .. "\n  pass"
end

function M.add_to_scene(scene_path, signal, node, destination, buf_type)
	local scene = vim.fn.readfile(scene_path)


  local signal_name = string.sub(signal, string.find(signal, ":") + 2, string.find(signal, "(", 1, true) - 1)
  local method
  local connection

	if buf_type == "cs" then
		method = "On" .. utils.pascal_case(node.name) .. utils.pascal_case(signal_name)
		connection = string.format(
			'[connection signal="%s" from="%s" to="%s" method="%s"]',
			signal_name,
			utils.get_full_path(node),
      destination,
			method
		)

		goto continue
	end

	method = "_on_" .. utils.snake_case(node.name) .. "_" .. signal_name
	connection = string.format(
		'[connection signal="%s" from="%s" to="%s" method="%s"]',
		signal_name,
		utils.get_full_path(node),
    destination,
		method
	)

  ::continue::

	table.insert(scene, connection)

	vim.fn.writefile(scene, scene_path)
end

return M
