extends Node2D

signal gift_picked

signal button_toggled(pressed,b_name)

var state : Array
var mask_array = [0,0,0]

func _ready() -> void:
	for i in range(24):
		state.append(false)
	randomize()
