extends Path2D


@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0


@onready var animation_player = $AnimationPlayer
@onready var path_follow_2d = $PathFollow2D



# Called when the node enters the scene tree for the first time.
func _ready():
	if not loop:
		animation_player.play("moving_platform")
		animation_player.speed_scale = speed_scale
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	path_follow_2d.progress += speed
