@tool

extends CanvasLayer

# Labels
@onready var _node_killed_label = get_node("KilledLabel")
@onready var _node_hp_label = get_node("HpLabel")

# Properties
@export var killed_count := 0 : set = _set_killed_count
@export var hp := 0 : set = _set_hp

func _set_killed_count(new_value):
	killed_count = new_value
	if(_node_killed_label != null):
		_node_killed_label.text = "KILLED: " + str(new_value)
	
func _set_hp(new_value):
	hp = new_value
	if(_node_hp_label != null):
		_node_hp_label.text = "HP: " + str(new_value)
