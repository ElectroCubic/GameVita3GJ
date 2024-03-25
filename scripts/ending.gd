extends Node2D

func _on_quit_btn_pressed():
	$Audio/ClickSound.play()
	await $Audio/ClickSound.finished
	get_tree().quit()

func _on_restart_btn_pressed():
	$Audio/ClickSound.play()
	await $Audio/ClickSound.finished
	Globals.health = 5
	TransitionLayer.change_scene(Globals.selectRandomLevelFromSet1())
