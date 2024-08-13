extends Control
var command
var timescale
var maxlevel = 0
@onready var path = "res://scenes/base_cell.tscn"
@onready var basecell = $GridContainer/Panel/basecell
@onready var stairs = $GridContainer/Panel3/stairs
@onready var elev = $GridContainer/Panel4/elevator
@onready var del = $GridContainer/Panel5/del
@onready var test = $GridContainer/Panel2/Button
var buildingroot
func _ready():
	buildingroot = get_node("/root/mainScene/Building")
	
	
func get_cell_type():
	return path

func _on_basecell_pressed():
	command = "add_cell"
	path = "res://scenes/base_cell.tscn"
	load(path)
	pass # Replace with function body.


func _on_stairs_pressed():
	command = "add_stairs"
	path = "res://scenes/stairs.tscn"
	pass # Replace with function body.


func _on_elevator_pressed():
	command = "add_elevator"
	path = "res://scenes/elevator_wall.tscn"
	pass # Replace with function body.


func _on_del_pressed():
	command = "del"
	pass # Replace with function body.


func _on_timescale_pressed():
	
	print(self.get_parent())
	timescale += 500;
	pass # Replace with function body.


func _on_newfloor_pressed():
	var BaseCell = preload("res://scenes/base_cell.tscn")
	var groundfloor = get_node("/root/mainScene/Building/Floor")
	var buildnode = get_node("/root/mainScene/Building")
	var coords = groundfloor.get_cell_coord_dict()
	var lastkey = coords.keys()[-1]
	var lastpos = coords[lastkey]
	print(lastpos)
	if BaseCell.can_instantiate():
		var newcell = BaseCell.instantiate()
		print(newcell)
		newcell.translate(Vector3(0,groundfloor.get_floor_level()+3,0) + lastpos)
		var newFloor = Node3D.new()
		buildnode.add_child(newFloor)
		var newfloor= groundfloor.duplicate()
		maxlevel+=1
		newfloor.translate(Vector3(0.0,maxlevel*3,0.0))
		newFloor.add_child(newfloor)
		newFloor.set_script("res://scripts/cell_logic.gd")
		
	pass # Replace with function body.
