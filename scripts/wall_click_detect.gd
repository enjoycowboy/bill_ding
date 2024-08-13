extends Node3D
var selectable = true;
var click_count = 0;
var can_expand = false;
var deletable = false;
var uilayer

func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.double_click ==true:

			self.visible = !self.visible

		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			if uilayer.command == "del":
				deletable = !deletable
			else:
				can_expand = true;
			
func _ready():
	var root = get_node("/root/mainScene")
	uilayer = root.get_node("/root/mainScene/interface")
	pass

func _physics_process(delta):
	pass


func _on_static_body_3d_mouse_entered():
	var nodes = self.get_children()
	for node in nodes:
		node.set_transparency(0.9)
	pass # Replace with function body.


func _on_static_body_3d_mouse_exited():
	var nodes = get_children()
	for node in nodes:
		node.set_transparency(0.0)
	pass # Replace with function body.
