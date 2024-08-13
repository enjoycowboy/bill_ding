extends Node3D
const NORTH = 0 # +z
const EAST = 1 # +x
const SOUTH = 2 # -z
const WEST = 3 # -x
var level = 0
var cell_coord_dict = {};
var BaseCell = preload("res://scenes/base_cell.tscn")
var root
var uilayer
var freetargets = []
func _increment_level():
	level+=1

func get_floor_level():
	return level

func _ready():
	root = get_node("/root/mainScene")
	uilayer = root.get_node("/root/mainScene/interface")
	if BaseCell.can_instantiate():
		var base = BaseCell.instantiate()
		self.add_child(base)
		cell_coord_dict.merge({base: base.position})

func get_cell_coord_dict():
	return cell_coord_dict

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
	var overlaps = _cell_is_overlapping(cell_coord_dict)
	if overlaps:
		_unplop(overlaps)
	for node in freetargets:
		pass
		#node.queue_free()
	freetargets.clear()

func _go_north(new_cell, original_cell):
	var newpos = Vector3(5.0,level*5,0.0)
	var mypos = original_cell.get_parent_node_3d().position
	new_cell.translate(mypos+newpos)
	var dict = {new_cell: new_cell.position}
	cell_coord_dict.merge(dict)

func _go_south(new_cell, original_cell):
	var newpos = Vector3(-5.0,level*5,0.0)
	var mypos = original_cell.get_parent_node_3d().position
	new_cell.global_translate(mypos+newpos)
	var dict = {new_cell: new_cell.position}
	cell_coord_dict.merge(dict)

func _go_east(new_cell, original_cell):
	var newpos = Vector3(0.0,level*5,5.0)
	var mypos = original_cell.get_parent_node_3d().position
	new_cell.translate(mypos+newpos)
	var dict = {new_cell: new_cell.position}
	cell_coord_dict.merge(dict)

func _go_west(new_cell, original_cell):
	var newpos = Vector3(0.0,level*5,-5.0)
	var mypos = original_cell.get_parent_node_3d().position
	new_cell.translate(mypos+newpos)
	var dict = {new_cell: new_cell.position}
	cell_coord_dict.merge(dict)

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
	var cell_to_add = load(uilayer.get_cell_type())
	#tem que andar a arvore inteira e descobrir de onde ta vindo o sinal
	for node in get_children():
		for child in node.get_children():
			if child.has_method("_on_static_body_3d_input_event"):
				if child.can_expand:
					if cell_to_add.can_instantiate():
						var newCell = cell_to_add.instantiate()
						child.can_expand = false
						_plop(newCell,child)
						self.add_child(newCell)
						
				if child.deletable:
					freetargets.append(child)
			else:
				continue

					
func _unplop(duplicates : Dictionary):
	var tofree = []
	for key in duplicates.keys():
		var nodes = duplicates[key]
		for i in range (1,nodes.size()):
			var node = nodes[i]
			if node:
				tofree.append(node)
	for node in tofree:
		if node.get_parent():
			node.get_parent().remove_child(node)
	print(tofree)

func _cell_is_overlapping(input_dict):
	var value_to_keys = {}
	var duplicates = {}
	
	for key in input_dict.keys():
		var value = input_dict[key]
		
		# Track the keys associated with each value
		if value in value_to_keys:
			value_to_keys[value].append(key)
		else:
			value_to_keys[value] = [key]
	
	# Find all values that have more than one key associated with them
	for value in value_to_keys.keys():
		if value_to_keys[value].size() > 1:
			duplicates[value] = value_to_keys[value]
	
	return duplicates
