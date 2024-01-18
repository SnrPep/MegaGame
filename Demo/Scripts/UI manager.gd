extends CanvasLayer

func _ready():
	GameManager.pause_menu = $Pause_menu

func _process(_delta):
	if Input.is_action_just_pressed("pause") && !GameManager.dialogue_playing:
		GameManager.pause_play()

func _on_resume_pressed():
	GameManager.resume()

func _on_restart_pressed():
	GameManager.restart()

func _on_menu_pressed():
	GameManager.MainMenu()

func _on_quit_pressed():
	GameManager.quit()
