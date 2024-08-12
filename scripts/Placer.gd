extends Control
var command
var timescale
@onready var path = "res://scenes/base_cell.tscn"
@onready var basecell = $GridContainer/Panel/basecell
@onready var stairs = $GridContainer/Panel3/stairs
@onready var elev = $GridContainer/Panel4/elevator
@onready var del = $GridContainer/Panel5/del
@onready var test = $GridContainer/Panel2/Button

func get_cell_type():
	return path

func _on_basecell_pressed():
	command = "add_cell"
	path = "res://scenes/base_cell.tscn"
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
