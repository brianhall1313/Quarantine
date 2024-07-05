extends Node

@onready var landing_particle = preload("res://landing_particle.tscn")
@onready var wipe = preload("res://wipe.tscn")

var in_transition:bool = false


var default_completed_level_log:Array= [false,false,false,false,false,false,false,false,false,false]
var default_open_level_log:Array = [true,false,false,false,false,false,false,false,false,false]
var completed_level_log:Array = [false,false,false,false,false,false,false,false,false,false]
var open_level_log:Array = [true,false,false,false,false,false,false,false,false,false]
var level:int = 0


func _ready():
	GlobalSignalBus.connect("transition_done",unpause)
	GlobalSignalBus.connect("transition_start",pause)


func pause():
	print("pause")
	get_tree().paused = true

func unpause():
	print("unpause")
	get_tree().paused = false
