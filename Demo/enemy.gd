extends CharacterBody2D


var speed = -60.0
var player = false
var player_chase = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false

func _physics_process(delta):
	if player_chase:
		velocity.x = speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
	
	move_and_slide()

	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1


func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)

func die():
	queue_free()


func _on_detection_body_entered(area):
	player = area
	player_chase = true


func _on_detection_body_exited(area):
	player = null
	player_chase = false
