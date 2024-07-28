extends Node3D
var space_state;
var camera : Camera3D;
var inner_axis;
var mouse_pos;
var ray_result;
var butpress : bool = false;

func _ready():
	camera = get_node("InnerAxis/myCamera");
	inner_axis = get_node("InnerAxis");

func _cam_rotate():
	var mouse_curr = get_viewport().get_mouse_position()
	var move_diff = mouse_pos - mouse_curr
	var camera_gain = get_viewport().size.y * deg_to_rad(camera.fov)
	var angleX = move_diff.x / camera_gain
	var angleY = move_diff.y / camera_gain
	mouse_pos = mouse_curr
	inner_axis.rotate_object_local(Vector3.RIGHT, angleY)
	self.rotate_object_local(Vector3.UP, angleX)
	return
		
func _cam_pan():
	var mouse_pos_current = get_viewport().get_mouse_position()
	var diff = mouse_pos - mouse_pos_current
	var amount = tan(deg_to_rad(camera.fov / 2)) * diff / (get_viewport().size.y/2)
	# ajusta o ganho de acordo com a distância da camera ate a origem
	amount *= camera.transform.origin.length()
	mouse_pos = mouse_pos_current
	var motion_vector = Vector3(amount.x, 0, amount.y)
	self.translate(motion_vector)
		
func _generate_ray():
	butpress = true
	mouse_pos = get_viewport().get_mouse_position();
	var from = camera.project_ray_origin(mouse_pos);
	var to = camera.project_ray_normal(mouse_pos) * camera.far;
	space_state = get_world_3d().direct_space_state;
	var params = PhysicsRayQueryParameters3D.create(from, to);
	ray_result = space_state.intersect_ray(params)
	
	return ray_result

func _cam_zoom(zoom_in = 0):
	var step = camera.transform.origin.length()/5
	if zoom_in:
		camera.translate_object_local(Vector3(0,0,step))
	else:
		camera.translate_object_local(Vector3(0,0,-step))
		
func _translate_origin(ray_position, origin):
	var diff = ray_position - origin
	self.global_transform.origin = ray_position
	camera.global_translate(-diff)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_wheel_click"):
		var ray_result = _generate_ray()
		if ray_result:
			_translate_origin(ray_result.position, global_transform.origin)
	elif Input.is_action_just_released("ui_wheel_click"):
		butpress = false;

	if Input.is_key_pressed(KEY_SHIFT) and butpress:
		_cam_pan()
	
	elif butpress:
		_cam_rotate()
	
	if Input.is_action_just_released("ui_wheel_up"):
		_cam_zoom()
	if Input.is_action_just_released("ui_wheel_down"):
		_cam_zoom(1);
