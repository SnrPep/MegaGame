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
	if Input.is_action_just_pressed("attack") && !hit and !GameManager.dialogue_playing:
		attack()

func process(delta):
	if Input.is_action_just_pressed("attack") and !GameManager.dialogue_playing:
		attack()

func _physics_process(delta):
	if !GameManager.dialogue_playing:
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
	else:
		velocity.x = 0
		velocity.y = 0
		if not is_on_floor():
			velocity.y += gravity * delta * 10
	
	move_and_slide()
	update_animation()
	indoor()
	dialogue_area()
	
	if position.y >= 200:
		die()
	

func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	$Attack.play()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().take_damage(1)
	
	attacking = true
	animation.play("attack")

func update_animation():
	if !attacking && can_take_damage:
		if velocity.x != 0:
			animation.play("run")
		else:
			animation.play("idle")
		
		if velocity.y < 0 && velocity.y != 0:
			animation.play("Jump")
		elif velocity.y != 0:
			animation.play("fall")

func take_damage(damage_amount : int):
	if can_take_damage:
		$Damaged.play()
		iframes()
		health -= damage_amount
		
		hit = true
		attacking = false
		
		if health <= 0:
			animation.play("death")
			await get_tree().create_timer(0.95).timeout
			die()

func indoor():
	var overlapping_objects = $Hitbox.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("TP") && Input.is_action_just_pressed("interaction"):
			get_tree().change_scene_to_file("res://Level1.tscn")
		if area.get_parent().is_in_group("TP2") && Input.is_action_just_pressed("interaction"):
			get_tree().change_scene_to_file("res://Scenes/level1_night.tscn")
		if area.get_parent().is_in_group("TP3"):
			get_tree().change_scene_to_file("res://Scenes/forest.tscn")

func dialogue_area():
	var overlapping_objects = $Hitbox.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Kolya") && Input.is_action_just_pressed("Dialogue") && !GameManager.dialogue_playing:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/main.dialogue"), "start")
		if area.get_parent().is_in_group("dialog_2") && !GameManager.dialogue_playing && GameManager.dial2:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue_2.dialogue"), "start")
		if area.get_parent().is_in_group("dialog_2_1") && !GameManager.dialogue_playing && GameManager.dial21:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue_2_1.dialogue"), "start")
		if area.get_parent().is_in_group("dialog_2_2") && !GameManager.dialogue_playing && GameManager.dial22:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue_2_2.dialogue"), "start")
		if area.get_parent().is_in_group("dial_3") && Input.is_action_just_pressed("Dialogue") && !GameManager.dialogue_playing:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue_3.dialogue"), "start")
		if area.get_parent().is_in_group("dial_4") && Input.is_action_just_pressed("Dialogue") && !GameManager.dialogue_playing:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue_4.dialogue"), "start")
		if area.get_parent().is_in_group("dial_5") && Input.is_action_just_pressed("Dialogue") && !GameManager.dialogue_playing:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue_5.dialogue"), "start")
		if area.get_parent().is_in_group("dial_6") && Input.is_action_just_pressed("Dialogue") && !GameManager.dialogue_playing:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue_6.dialogue"), "start")

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true
	hit = false

func die():
	GameManager.respawn_player()
