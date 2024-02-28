extends CanvasLayer

func _ready():
	$MainMenu/VBoxContainer/HBoxContainer/Play.grab_focus()
	GameManager.main_menu = $MainMenu

func _on_settings_pressed():
	GameManager.settings_menu()

func _on_play_pressed():
	GameManager.play()

func _on_quit_pressed():
	GameManager.quit()
