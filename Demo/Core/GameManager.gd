extends Node

var current_checkpoint : Checkpoint
var pause_menu
var main_menu
var sett
 
var player : Player

var paused = false

var dialogue_playing = false
var kolya_free = false
var second_dial = true
var dial1 = true
var dial2 = true
var dial21 = true
var dial22 = true
var dial3 = true
var dial4 = true
var dial5 = true
var dial6 = true

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

func settings_play():
	paused = !paused
	get_tree().paused = paused
	sett.visible = paused

func settings_menu():
	settings_play()

func back():
	settings_play()

func game_paused():
	paused = !paused
	get_tree().paused = paused
