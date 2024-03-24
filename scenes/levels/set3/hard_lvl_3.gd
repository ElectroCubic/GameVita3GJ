extends Level


func _on_exit_door_player_touched():
	await get_tree().create_timer(0.5).timeout
	TransitionLayer.change_scene("res://scenes/ending.tscn")

func _on_red_door_player_touched():
	$Player.position = $Objects/BlueDoor.position

func _on_blue_door_player_touched():
	$Player.position = $Objects/RedDoor.position


func _on_red_door_2_player_touched():
	$Player.position = $Objects/BlueDoor2.position

func _on_blue_door_2_player_touched():
	$Player.position = $Objects/RedDoor2.position