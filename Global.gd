extends Node

@onready var explosion = preload("res://explosion.tscn")
@onready var slime_explosion = preload("res://slime_explosion.tscn")
@onready var dood_explosion = preload("res://dood_explosion.tscn")
@onready var landing_particle = preload("res://landing_particle.tscn")
@onready var wipe = preload("res://wipe.tscn")

var in_transition:bool = false



func _ready():
	GlobalSignalBus.connect("transition_done",unpause)
	GlobalSignalBus.connect("transition_start",pause)


func pause():
	print("pause")
	get_tree().paused = true

func unpause():
	print("unpause")
	get_tree().paused = false
