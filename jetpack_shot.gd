extends Area2D


const SPEED = 200.0


func _physics_process(delta):
	position.y += SPEED * delta

func hit():
	queue_free()


func _on_body_entered(body):
	print("hit body")
	hit()
