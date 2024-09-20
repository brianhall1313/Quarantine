extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -400.0

@onready var right_floor_detection = $right_floor_detection
@onready var left_floor_detection = $left_floor_detection


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1
var turn_around:bool = false

func _ready():
	$AnimatedSprite2D.play("default")


func _physics_process(delta):
	if is_on_wall() or is_over_pit():
		turn_around = true
	if turn_around:
		change_direction()
	move(delta)
	attack()
	move_and_slide()


func get_hit():
	var new = Global.slime_explosion.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	new.explode()
	GlobalSignalBus.alien_death.emit()
	queue_free()

func change_direction():
		turn_around = false
		direction *= -1

func move(delta):
	velocity.x = direction * SPEED * delta
	if not is_on_floor():
		velocity.y += gravity * delta

func attack():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.has_method("take_damage"):
			if collider.alive:
				collider.take_damage()


func is_over_pit():
	if not right_floor_detection.get_collider():
		change_direction()
	if not left_floor_detection.get_collider():
		change_direction()
