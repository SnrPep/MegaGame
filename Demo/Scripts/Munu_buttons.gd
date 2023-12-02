extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.main_menu = $MainMenu


func _on_play_pressed():
	GameManager.play()

func _on_quit_pressed():
	GameManager.quit()
