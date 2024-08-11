extends Node3D
var selectable = true;
var click_count = 0;
var can_expand = false;

func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.double_click ==true:

			self.visible = !self.visible

		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			click_count+=1;
			if click_count == 1:
				can_expand = true;
			if click_count == 2:
				can_expand = false;
				click_count =0;
			
func _ready():
	pass

func _physics_process(delta):
	pass
