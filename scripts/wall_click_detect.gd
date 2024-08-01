extends Node3D
var selectable = true;
@onready var mesh = get_node(".");
var can_expand = true;
func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			if can_expand:
				var root = get_parent_node_3d();
				root._create_new(self.name)
	pass # Replace with function body.

func _ready():
	pass
	

	
	pass
