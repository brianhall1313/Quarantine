extends Node2D

@onready var walls_collision = $StaticBody2D/walls_collision
@onready var walls = $StaticBody2D/walls

# Called when the node enters the scene tree for the first time.
func _ready():
	walls.polygon = walls_collision.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
