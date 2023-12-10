extends Control

var dialog = []

func _ready():
	# Загрузка диалога из файла JSON
	var file = File.new()
	if file.open("res://dialog.json", File.READ) == OK:
		var content = file.get_as_text()
		dialog = JSON.parse(content)["dialog"]
		file.close()

	# Начать диалог
	start_dialog()

func start_dialog():
	for line in dialog:
		# Вывести текст диалога на экран (например, в метку Label)
		print(line["character"] + ": " + line["text"])

		# Ждать, пока игрок нажмет клавишу или событие продолжится
		await(get_tree().create_timer(2.0), "timeout")

	# Закончить диалог
	print("Dialog ended.")
