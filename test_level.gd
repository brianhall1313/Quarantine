extends Node2D

@onready var walls_collision = $StaticBody2D/walls_collision
@onready var walls = $StaticBody2D/walls
@onready var jetpack_temp = $player/Control/Jetpack_temp
@onready var player = $player
@onready var enemies = $enemies
@onready var door = $door

var check_win:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	walls.polygon = walls_collision.polygon
	connect_signalbus()
	setup_bar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemies.get_child_count() == 0 and check_win:
		print("win")
		door.unlock_door()
		check_win = false
	if Input.is_action_just_pressed("interact"):
		if door.player_in_area and door.unlocked:
			get_tree().quit()
			
		


func connect_signalbus():
	GlobalSignalBus.connect("temperature_update", update_jetpack_temp)


func update_jetpack_temp(new_temp):
	jetpack_temp.value = new_temp


func setup_bar():
	jetpack_temp.max_value = player.MAXTEMP
	jetpack_temp.min_value = player.MINTEMP


