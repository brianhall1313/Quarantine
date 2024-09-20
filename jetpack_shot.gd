extends Area2D


const SPEED = 400.0


func _physics_process(delta):
	position.y += SPEED * delta

func hit():
	var new = Global.explosion.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	new.explode()
	AudioController.explosion.play()
	queue_free()


func _on_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit()
	if not body.is_in_group("player"):
		hit()
