extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimatedSprite2D.play("default")


func _physics_process(delta):
	
	
	move_and_slide()


func get_hit():
	var new = Global.slime_explosion.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	new.explode()
	GlobalSignalBus.alien_death.emit()
	queue_free()
