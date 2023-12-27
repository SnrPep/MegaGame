extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var speed : float = 150.0
@export var jump_velocity : float = -170.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var attacking = false

var max_health = 3
var health = 0
var can_take_damage = true
@export var hit = false

func _ready():
	health = max_health
	GameManager.player = self

func _process(delta):
	if Input.is_action_just_pressed("attack") && !hit:
		attack()

func process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta):
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_velocity
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	indoor()
	
	if position.y >= 500:
		die()

func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().take_damage(1)
	
	attacking = true
	animation.play("attack")

func update_animation():
	if !attacking:
		if velocity.x != 0:
			animation.play("run")
		else:
			animation.play("idle")
		
		if velocity.y < 0:
			animation.play("jump")
		else:
			animation.play("fall")

func take_damage(damage_amount : int):
	if can_take_damage:
		iframes()
		health -= damage_amount
		
		$Healthbar.update_healthbar(health, max_health)
		
		hit = true
		attacking = false
		
		if health <= 0:
			die()

func indoor():
	var overlapping_objects = $Hitbox.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("TP") && Input.is_action_just_pressed("interaction"):
			get_tree().change_scene_to_file("res://Level1.tscn")

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true
	hit = false

func die():
	GameManager.respawn_player()
