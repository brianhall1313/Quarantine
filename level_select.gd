extends Node2D

@onready var button_icon = preload("res://button.png")
@onready var locked_button_icon = preload("res://button_locked.png")
@onready var completed_button_icon = preload("res://button_complete.png")

@onready var level_grid = $Control/VBoxContainer/level_grid


# Called when the node enters the scene tree for the first time.
func _ready():
	for level in level_grid.get_children():
		if Global.completed_level_log[int(level.text)]:
			level.icon = completed_button_icon
		elif Global.open_level_log[int(level.text)]:
			level.icon = button_icon
		else:
			level.icon = locked_button_icon
			level.disabled = true
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
	Global.level = 0
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_0.tscn")
	
func _on_1_button_up():
	Global.level = 1
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_1.tscn")
	
func _on_2_button_up():
	Global.level = 2
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_2.tscn")
	
func _on_3_button_up():
	Global.level = 3
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_3.tscn")
	
func _on_4_button_up():
	Global.level = 4
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_4.tscn")	

func _on_5_button_up():
	Global.level = 5
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_5.tscn")


func _on_6_button_up():
	Global.level = 6
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_6.tscn")


func _on_7_button_up():
	Global.level = 7
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_7.tscn")


func _on_8_button_up():
	Global.level = 8
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_8.tscn")



func _on_9_button_up():
	Global.level = 9
	transition_to_level()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://level_9.tscn")
