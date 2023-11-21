extends Node

var current_checkpoint : Checkpoint
 
var player : Player

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
