extends Node3D
var selectable = true;
@onready var mesh = get_node(".");

func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			print("Click Wall")
			print(mesh)
			
	pass # Replace with function body.

func _ready():
	pass
	
func _on_static_body_3d_mouse_entered():
	pass # Replace with function body.

func _on_static_body_3d_mouse_exited():
	pass # Replace with function body.
