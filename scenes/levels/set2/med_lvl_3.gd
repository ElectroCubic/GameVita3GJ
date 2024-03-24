extends Level

func _on_exit_door_player_touched():
	await get_tree().create_timer(0.5).timeout
	TransitionLayer.change_scene(Globals.selectRandomLevelFromSet3())
