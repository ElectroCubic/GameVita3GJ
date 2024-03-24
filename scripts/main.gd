extends Node2D

func playClickSound():
	$Audio/ClickSound.play()

func _on_play_btn_pressed():
	playClickSound()
	await get_tree().create_timer(1).timeout
	TransitionLayer.change_scene(Globals.selectRandomLevelFromSet1())

func _on_quit_btn_pressed():
	playClickSound()
	await get_tree().create_timer(1).timeout
	get_tree().quit()
	
