extends Node3D
const NORTH = 0 # +z
const EAST = 1 # +x
const SOUTH = 2 # -z
const WEST = 3 # -x
var levels = [0,0,0,0]
func _ready():
	pass
func _create_new(name):
	var new_cell = Node3D.new()
	print(name)
	for child in self.get_children():
		if child.name == name:
			continue
		new_cell.add_child(child.duplicate())
	_plop(new_cell, name)

func _plop(new_cell, original_cell):
	match original_cell:
		"WestWall":
			_go_west(new_cell)
		"NorthWall":
			_go_north(new_cell)
		"SouthWall":
			_go_south(new_cell)
		"EastWall":
			_go_east(new_cell)

func _go_north(new_cell):
	levels[NORTH]+=1
	new_cell.translate(Vector3(levels[NORTH] * 5,0.1,0.0))
	var root = self.get_parent_node_3d()
	root.add_child(new_cell)
	print(levels)
	
func _go_south(new_cell):
	levels[SOUTH]+=1
	print(levels)
	pass

func _go_east(new_cell):
	levels[EAST]+=1
	print(levels)
	pass

func _go_west(new_cell):
	levels[WEST]+=1
	print(levels)
	pass
