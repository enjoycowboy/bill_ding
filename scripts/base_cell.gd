extends Node3D
const NORTH = 0
const EAST = 1
const SOUTH = 2
var coordinates = [0,0]
func _ready():
	var pos = get_global_position() -Vector3(0,0,0)
	coordinates[NORTH] = pos[0]/5
	coordinates[EAST] = pos[2]/5

func _get_coordinates():
	return coordinates

