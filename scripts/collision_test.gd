extends CharacterBody3D


var start_pos : Vector3
var target_pos : Vector3
var move_speed : float = 1
var move_dir : Vector3


func _on_ready():
	move_dir = Vector3(randf_range(-10, 10), 1, randf_range(-10,10))
	start_pos = self.global_position
	target_pos = start_pos + move_dir
	

func _physics_process(delta):
	global_position = global_position.move_toward(target_pos,move_speed * delta)
	if move_and_slide():
		target_pos = Vector3(randf_range(-10, 10), 0.2, randf_range(-10,10))
		global_position = global_position.move_toward(target_pos,move_speed * delta)
		
	

