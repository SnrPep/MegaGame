extends Node

var current_checkpoint : Checkpoint
var pause_menu
var main_menu
 
var player : Player

var paused = false

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func pause_play():
	paused = !paused
	
	pause_menu.visible = paused

func resume():
	pause_play()

func restart():
	get_tree().reload_current_scene()

func MainMenu():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func quit():
	get_tree().quit()

func play():
	get_tree().change_scene_to_file("res://Level1.tscn")
