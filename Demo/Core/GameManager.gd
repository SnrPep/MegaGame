extends Node

var current_checkpoint : Checkpoint
var pause_menu
var main_menu
 
var player : Player

var paused = false

var dialogue_playing = false
var kolya_free = false

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func pause_play():
	paused = !paused
	get_tree().paused = paused
	pause_menu.visible = paused

func resume():
	pause_play()

func restart():
	get_tree().reload_current_scene()
	pause_play()

func MainMenu():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pause_play()

func quit():
	get_tree().quit()

func play():
	get_tree().change_scene_to_file("res://Scenes/level_0.tscn")

func game_paused():
	paused = !paused
	get_tree().paused = paused
