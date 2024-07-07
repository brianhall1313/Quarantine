extends CPUParticles2D


func explode():
	emitting = true

func _on_finished():
	queue_free()
