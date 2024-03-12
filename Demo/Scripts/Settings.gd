extends CanvasLayer

func _ready():
	$Setting/VBoxContainer/HBoxContainer2/Back.grab_focus()
	GameManager.sett = $Setting

func _on_back_pressed():
	GameManager.back()

func _on_other_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_musuc_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
