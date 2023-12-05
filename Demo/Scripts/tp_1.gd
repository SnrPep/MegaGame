extends Node2D

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		get_tree().change_scene_to_file("res://Level1.tscn")
