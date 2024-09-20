extends Sprite2D

@onready var open_door = preload("res://door_unlocked.png")
@onready var locked_door = preload("res://door_locked.png")

var player_in_area: bool = false
var unlocked: bool = false

func unlock_door():
	unlocked = true
	texture = open_door
	AudioController.door.play()


func _on_interaction_area_body_entered(area):
	if area.is_in_group("player"):
		player_in_area = true
		print("player has entered door")

func _on_interaction_area_body_exited(area):
	if area.is_in_group("player"):
		player_in_area = false
		print("player has left door")
