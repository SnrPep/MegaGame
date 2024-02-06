extends CharacterBody2D

var speed = -60.0
var player = false
var player_chase = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false
var health = 1
var hit = false
var can_take_damage = true

func _physics_process(delta):
	velocity.x = speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$RayCast2D.is_colliding() && is_on_floor() || $RayCast2D2.is_colliding():
		flip()
	
	move_and_slide()

	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func die():
	velocity.x = 0
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	queue_free()

func take_damage(damage_amount : int):
	if can_take_damage:
		iframes()
		health -= damage_amount
		
		hit = true
		
		if health <= 0:
			die()

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)
