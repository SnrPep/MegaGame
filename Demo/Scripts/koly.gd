extends CharacterBody2D

func _physics_process(delta):
	if GameManager.kolya_free:
		queue_free()
		GameManager.kolya_free = false
