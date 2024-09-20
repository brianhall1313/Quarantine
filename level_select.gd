extends Node2D

@onready var button_icon = preload("res://button.png")
@onready var locked_button_icon = preload("res://button_locked.png")
@onready var completed_button_icon = preload("res://button_complete.png")

@onready var level_grid = $Control/VBoxContainer/level_grid


# Called when the node enters the scene tree for the first time.
func _ready():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_left()
	$"Control/VBoxContainer/level_grid/0".grab_focus()


func _process(_delta):
	if Input.is_action_just_pressed("back"):
		exit()

func transition_to_level():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_right()

func exit():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_out()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://main.tscn")

func _on_back_button_up():
	exit()


func _on_0_button_up():
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://tutorial.tscn")


func _on_1_button_up():
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_2_button_up():
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_2.tscn")


func _on_3_button_up():
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_3.tscn")
