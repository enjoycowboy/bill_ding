extends Node3D
const NORTH = 0 # +z
const EAST = 1 # +x
const SOUTH = 2 # -z
const WEST = 3 # -x
var levels = [0,0,0,0]
const BaseCell = preload("res://base_cell.tscn")
func _ready():
	if BaseCell.can_instantiate():
		var base = BaseCell.instantiate()
		self.add_child(base)

func _plop(new_cell, original_cell):
	match original_cell.name:
		"WestWall":
			var new_wall = new_cell.find_child(opposite_of("WestWall"), true)
			if new_wall:
				new_wall.visible=false
				if original_cell.name == opposite_of(new_wall.name):
					original_cell.visible=false
			_go_west(new_cell, original_cell)
		"NorthWall":
			var new_wall = new_cell.find_child(opposite_of("NorthWall"), true)
			if new_wall:
				new_wall.visible=false
				if original_cell.name == opposite_of(new_wall.name):
					original_cell.visible=false
			_go_north(new_cell, original_cell)
		"SouthWall":
			var new_wall = new_cell.find_child(opposite_of("SouthWall"), true)
			if new_wall:
				new_wall.visible=false
				if original_cell.name == opposite_of(new_wall.name):
					original_cell.visible=false
			_go_south(new_cell, original_cell)
		"EastWall":
			var new_wall = new_cell.find_child(opposite_of("EastWall"), true)
			if new_wall:
				new_wall.visible=false
				if original_cell.name == opposite_of(new_wall.name):
					original_cell.visible=false
			_go_east(new_cell, original_cell)

func _go_north(new_cell, original_cell):
	levels[NORTH]+=1
	var newpos = Vector3(5.0,0.0,0.0)
	var mypos = original_cell.get_parent_node_3d().position
	new_cell.translate(mypos+newpos)

<<<<<<< Updated upstream
<<<<<<< HEAD
=======

>>>>>>> master
=======
>>>>>>> Stashed changes
func _go_south(new_cell, original_cell):
	levels[SOUTH]+=1
	var newpos = Vector3(-5.0,0.0,0.0)
	var mypos = original_cell.get_parent_node_3d().position
	new_cell.global_translate(mypos+newpos)

func _go_east(new_cell, original_cell):
	levels[EAST]+=1
	var newpos = Vector3(0.0,0.0,5.0)
	var mypos = original_cell.get_parent_node_3d().position
	new_cell.translate(mypos+newpos)

func _go_west(new_cell, original_cell):
	levels[WEST]+=1
	var newpos = Vector3(0.0,0.0,-5.0)
	var mypos = original_cell.get_parent_node_3d().position
	new_cell.translate(mypos+newpos)

static func opposite_of(direction):
	match direction:
		"WestWall":
			return "EastWall"
		"NorthWall":
			return "SouthWall"
		"SouthWall":
			return "NorthWall"
		"EastWall":
			return "WestWall"

func _physics_process(delta):
	#tem que andar a arvore inteira e descobrir de onde ta vindo o sinal
	for node in get_children():
		for child in node.get_children():
			if child.has_method("_on_static_body_3d_input_event"):
				if child.can_expand:
					if BaseCell.can_instantiate():
						var newCell = BaseCell.instantiate()
						child.can_expand = false
						_plop(newCell,child)
						self.add_child(newCell)
						var overlaps = _cell_is_overlapping(newCell)
						_unplop(overlaps)

func _unplop(nodes):
	print(nodes)
	for node in nodes:
		node.queue_free()
	pass

func _cell_is_overlapping(node):
	var overlaps = []
	var mypos = node.get_global_position
	for child in node.get_parent_node_3d().get_children():
		if child == node:
			continue
		if child.get_global_position() == node.get_global_position():
			overlaps.append(child)
	return overlaps
