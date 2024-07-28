extends MeshInstance3D
var space_state;
var camera : Camera3D;
var mouse_pos;
var ray_result;
var butpress : bool = false;
var params;
func _generate_ray():
	butpress = true
	mouse_pos = get_viewport().get_mouse_position();
	var from = camera.project_ray_origin(mouse_pos);
	var to = camera.project_ray_normal(mouse_pos) * camera.far;
	space_state = get_world_3d().direct_space_state;
	params = PhysicsRayQueryParameters3D.create(from, to);
	ray_result = space_state.intersect_ray(params)
	return ray_result

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_wheel_click"):
		var ray_result = _generate_ray()
		if ray_result:
			_digest_collision(params)

func _ready():
	camera = get_node("InnerAxis/myCamera");

func _digest_collision(params):
	print(params)
