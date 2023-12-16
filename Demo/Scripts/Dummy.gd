extends CharacterBody2D
@onready var animation = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hit = false
var can_take_damage = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	update_animation()
	move_and_slide()

func update_animation():
	if !hit:
		animation.play("idle")

func take_damage(damage_amount : int):
	if can_take_damage:
		iframes()
		animation.play("hit")
		
		hit = true

func iframes():
	can_take_damage = false
	await get_tree().create_timer(0.5).timeout
	can_take_damage = true
	hit = false
