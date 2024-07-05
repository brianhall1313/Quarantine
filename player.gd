extends CharacterBody2D

const AIRJUMPSMAX = 5

@onready var shot = preload("res://jetpack_shot.tscn")
@onready var coyote_timer = $coyote_time
@onready var jetpack_time = $jetpack_time
@onready var animated_sprite = $animated_sprite
@onready var jetpack = $jetpack
@onready var right_flames = $jetpack/right_flames
@onready var left_flames = $jetpack/left_flames


@export var movement_data: PlayerMovementData

var sprite_height:float = 16
var is_jumping:bool = false
var is_falling:bool = false
var wall_jump_available:bool = false
var floor_offset:float = sprite_height/2
var air_jumps:int = AIRJUMPSMAX


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animated_sprite.play("idle")
		

func _physics_process(delta):
	if (is_jumping or is_falling) and is_on_floor():
		is_jumping = false
		is_falling = false
		air_jumps = AIRJUMPSMAX
		landing_animation()
	handle_gravity(delta)
	var direction = Input.get_axis("left", "right")
	handle_jump()
	handle_acceleration(direction,delta)
	handle_air_acceleration(direction,delta)
	handle_friction(direction,delta)
	handle_air_resistance(direction,delta)
	handle_animation(direction)
	var was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor and not is_on_floor() and not is_jumping:
		is_falling = true
		coyote_timer.start()



func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta




func handle_jump():
	if  is_on_floor() or coyote_timer.time_left > 0:
		if Input.is_action_just_pressed("jumpfire"):
			is_jumping = true
			jetpack_shot()
			velocity.y = movement_data.jump_velocity
			AudioController.jump.play()
	if not is_on_floor():
		if Input.is_action_just_pressed("jumpfire") and (is_falling or is_jumping):
			if air_jumps > 0 :
				air_jumps -= 1
				jetpack_shot()
				velocity.y = movement_data.air_jump_velocity
		
		if Input.is_action_just_released("jumpfire"):
			if velocity.y < movement_data.jump_velocity/2:
				velocity.y = movement_data.jump_velocity/2


func handle_acceleration(direction,delta):
	if direction != 0 and is_on_floor():
		velocity.x = move_toward(velocity.x,direction * movement_data.speed,movement_data.acceleration*delta)

func handle_air_acceleration(direction,delta):
	if direction != 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x,direction * movement_data.speed,movement_data.air_acceleration*delta)

func handle_friction(direction,delta):
	if direction==0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction*delta)

func handle_air_resistance(direction,delta):
	if direction==0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance*delta)




func take_damage():
	AudioController.damage.play()
	var new = Global.key_particle.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	new.explode()
	GlobalSignalBus.player_damage.emit()


	
func landing_animation():
	AudioController.landing.play()
	var new = Global.landing_particle.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	new.position.y = position.y+floor_offset
	new.explode()


func handle_animation(direction):
	if not is_on_floor():
		animated_sprite.play("jump")
		animated_sprite.flip_h = direction<0
		jetpack.flip_h = direction<0
		if velocity.y <= 0:
			if jetpack.flip_h:
				left_flames.emitting = true
				right_flames.emitting = false
			if not jetpack.flip_h:
				right_flames.emitting = true
				left_flames.emitting = false
			jetpack_time.start()
		else:
			engines_off()
		return
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
		animated_sprite.flip_h = direction<0
		jetpack.flip_h = direction<0
	engines_off()


func engines_off():
	if right_flames.emitting == true:
		right_flames.emitting = false
	if left_flames.emitting == true:
		left_flames.emitting = false

func jetpack_shot():
	var new = shot.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	if right_flames.emitting == true:
		new.position = right_flames.global_position
	if left_flames.emitting == true:
		new.position = left_flames.global_position
