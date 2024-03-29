extends CanvasLayer

func _ready():
	$Setting/VBoxContainer/HBoxContainer2/Back.grab_focus()
	GameManager.sett = $Setting

func _on_back_pressed():
	GameManager.back()
# громкость всего остального
func _on_other_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

# громкость музыки
func _on_musuc_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

# 0 - полноэкрнанный, 1 - оконный, 2 - окно без рамок
func _on_display_mode_o_item_selected(index):
	pass # Replace with function body.


func _on_display_fpsch_toggled(button_pressed):
	pass # Replace with function body.
