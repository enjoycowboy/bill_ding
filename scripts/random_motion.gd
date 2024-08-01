extends Node3D

var start_pos : Vector3
var target_pos : Vector3
var move_speed : float = 1
var move_dir : Vector3


func _on_ready():
	move_dir = Vector3(randf_range(-10, 10), 0.1, randf_range(-10,10))
	start_pos = self.global_position
	target_pos = start_pos + move_dir
	

func _physics_process(delta):
	global_position = global_position.move_toward(target_pos,move_speed * delta)
	if global_position == target_pos:
		move_dir = Vector3(randf_range(-10, 10), 0.1, randf_range(-10,10))
		if global_position == start_pos:
			target_pos = start_pos + move_dir
		else:
			target_pos = start_pos

