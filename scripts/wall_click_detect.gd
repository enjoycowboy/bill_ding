extends Node3D
var selectable = true;
var can_expand = false;
func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			can_expand = true;
			
func _ready():
	pass
	
func _physics_process(delta):
	pass
