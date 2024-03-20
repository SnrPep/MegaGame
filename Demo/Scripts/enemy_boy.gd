extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

var speed = -60.0
var player = false
var player_chase = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move = false
var dead = false

var facing_right = false
var health = 1
var hit = false
var can_take_damage = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if can_move && !dead:
		velocity.x = speed
		
		'if !$RayCast2D.is_colliding() && is_on_floor() || $RayCast2D2.is_colliding():
			flip()'
		
	move_and_slide()

	
func flip():
	facing_right = !facing_right
	
	if facing_right:
		sprite.scale.x = abs(sprite.scale.x) * -1
		speed = abs(speed)
	else:
		sprite.scale.x = abs(sprite.scale.x)
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
			dead = true
			die()

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead:
		area.get_parent().take_damage(1)

func _on_right_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		can_move = true
		if !facing_right:
			flip()


func _on_left_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		can_move = true
		if facing_right:
			flip()
