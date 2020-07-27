extends Control

onready var ball_1 : RigidBody2D = get_node("Ej-1/ball-1")
onready var block_1 : RigidBody2D = get_node("Ej-1/block-1")
onready var gift_1 : RigidBody2D = get_node("Ej-1/gift-1")

onready var ball_2 : RigidBody2D = get_node("Ej-2/ball-2")
onready var block_2 : RigidBody2D = get_node("Ej-2/block-2")
onready var gift_2 : RigidBody2D = get_node("Ej-2/gift-2")

onready var ball_3 : RigidBody2D = get_node("Ej-3/ball-3")
onready var block_3 : RigidBody2D = get_node("Ej-3/block-3")
onready var gift_3 : RigidBody2D = get_node("Ej-3/gift-3")

onready var ball_lab1 : Label = get_node("Ej-1/ball-1/Label")
onready var block_lab1 : Label = get_node("Ej-1/block-1/Label")
onready var gift_lab1 : Label = get_node("Ej-1/gift-1/Label")

onready var ball_lab2 : Label = get_node("Ej-2/ball-2/Label")
onready var block_lab2 : Label = get_node("Ej-2/block-2/Label")
onready var gift_lab2 : Label = get_node("Ej-2/gift-2/Label")

onready var ball_lab3 : Label = get_node("Ej-3/ball-3/Label")
onready var block_lab3 : Label = get_node("Ej-3/block-3/Label")
onready var gift_lab3 : Label = get_node("Ej-3/gift-3/Label")

onready var top_menu : Control = get_node("TopMenu")

var balls : Array
var gifts : Array
var blocks : Array

var lay_ball = ["lay-ball-1","lay-ball-2","lay-ball-3"]
var mask_ball = ["mask-ball-1","mask-ball-2","mask-ball-3"]

var lay_gift = ["lay-gift-1","lay-gift-2","lay-gift-3"]
var mask_gift = ["mask-gift-1","mask-gift-2","mask-gift-3"]

var lay_block = ["lay-block-1","lay-block-2","lay-block-3"]
var mask_block = ["mask-block-1","mask-block-2","mask-block-3"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLOBALS.connect("button_toggled",self,"on_pressed")
	balls  = [ball_1, ball_2, ball_3]
	gifts  = [gift_1, gift_2, gift_3]
	blocks = [block_1, block_2, block_3]
	#Load button, layer and masks collisions
	load_state(GLOBALS.state)

func _input(event):
	if event.is_action_pressed("restart"):
		restart()
	if event.is_action_pressed("test1"):
		print("Start Test 1")
		ball_1.linear_velocity = Vector2(0,300)
	if event.is_action_pressed("test2"):
		print("Start Test 2")
		block_2.linear_velocity = Vector2(0,300)
	if event.is_action_pressed("test3"):
		print("Start Test 3")
		gift_3.linear_velocity = Vector2(0,300)

func change_collision(type : String, nodes : Array, pos : int, pressed : int) -> void:
	var sig = -1
	for node in nodes:
		if pressed:
			sig = 1
		if type == "lay":
			node.collision_layer += sig*pow(2,pos)
		elif type == "mask":
			node.collision_mask += sig*pow(2,pos)


func on_pressed(pressed : bool, b_name : String) -> void:
	if b_name in lay_ball:
		change_collision("lay",balls,lay_ball.find(b_name),pressed)
	elif b_name in mask_ball:
		change_collision("mask",balls,mask_ball.find(b_name),pressed)
	elif b_name in lay_gift:
		change_collision("lay",gifts,lay_gift.find(b_name),pressed)
	elif b_name in mask_gift:
		change_collision("mask",gifts,mask_gift.find(b_name),pressed)
	elif b_name in lay_block:
		change_collision("lay",blocks,lay_block.find(b_name),pressed)
	elif b_name in mask_block:
		change_collision("mask",blocks,mask_block.find(b_name),pressed)


func _on_ball1_body_entered(body: Node) -> void:
	#ball_lab1.visible = true
	var lab : Label = body.get_node("Label")
	lab.visible = true


func _on_block1_body_entered(body: Node) -> void:
	#block_lab1.visible = true
	var lab : Label = body.get_node("Label")
	lab.visible = true


func _on_gift1_body_entered(body: Node) -> void:
	#gift_lab1.visible = true
	var lab : Label = body.get_node("Label")
	lab.visible = true

func save_state() -> Array:
	var state : Array
	for child in top_menu.get_children():
		if child is CheckBox:
			state.append(child.pressed)
	return state

func load_state(state : Array) -> void:
	var i := 0
	for child in top_menu.get_children():
		if child is CheckBox:
			if state[i]:
				child.pressed = true
				#on_pressed(true, child.name)
			i += 1

func restart() -> void:
	#Save button states
	GLOBALS.state = save_state()
	print("Restart")
	get_tree().reload_current_scene()


func _on_test1_but_pressed() -> void:
	print("Start Test 1")
	ball_1.linear_velocity = Vector2(0,300)

func _on_test2_but_pressed() -> void:
	print("Start Test 2")
	block_2.linear_velocity = Vector2(0,300)

func _on_test3_but_pressed() -> void:
	print("Start Test 3")
	gift_3.linear_velocity = Vector2(0,300)


func _on_test1_but2_pressed() -> void:
	restart()


