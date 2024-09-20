extends Node2D

@onready var jetpack_temp = $player/Control/Jetpack_temp
@onready var player = $player
@onready var enemies = $enemies
@onready var door = $door


var is_paused:bool = false
var check_win:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signalbus()
	setup_bar()
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_left()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if enemies.get_child_count() == 0 and check_win:
		print("win")
		door.unlock_door()
		check_win = false
	if Input.is_action_just_pressed("interact"):
		if door.player_in_area and door.unlocked and player.is_on_floor():
			AudioController.descent.play()
			get_tree().change_scene_to_file("res://level_select.tscn")
			
	if Input.is_action_just_pressed("back"):
		get_tree().change_scene_to_file("res://level_select.tscn")
		
		
func reload():
	get_tree().reload_current_scene()

func connect_signalbus():
	GlobalSignalBus.connect("temperature_update", update_jetpack_temp)
	GlobalSignalBus.connect("player_death_finished",reload)


func update_jetpack_temp(new_temp):
	jetpack_temp.value = new_temp


func setup_bar():
	jetpack_temp.max_value = player.MAXTEMP
	jetpack_temp.min_value = player.MINTEMP
	jetpack_temp.value = 0
