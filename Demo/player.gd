extends CharacterBody2D

@export var speed : float = 150.0
@export var jump_velocity : float = -150.0
@export var double_jump_velocity : float = -100.0


@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_loced : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		if was_in_air == true:
			land()
		was_in_air = false

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif not has_double_jumped:
			double_jump()

#	if Input.is_action_just_pressed("attack"):
#		attack()

	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && animated_sprite.animation != "fall":
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	if not animation_loced:
		if direction.x != 0:
			animated_sprite.play("run")
		else: 
			animated_sprite.play("idle")
			
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump")
	animation_loced = true
	
func double_jump():
	velocity.y = double_jump_velocity
	animated_sprite.play("double_jump")
	animation_loced = true
	has_double_jumped = true
	
func land():
	animated_sprite.play("fall")
	animation_loced = false

func _on_animated_sprite_2d_animation_finished():
	if (["fall", "double_jump", "jump"].has(animated_sprite.animation)):
		animation_loced = false
