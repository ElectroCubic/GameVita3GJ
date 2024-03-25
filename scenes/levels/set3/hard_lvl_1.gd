extends Level

func _on_red_door_player_touched():
	$Player.position = $Objects/BlueDoor.position

func _on_blue_door_player_touched():
	$Player.position = $Objects/RedDoor.position

func _on_exit_door_player_touched():
	await get_tree().create_timer(0.5).timeout
	TransitionLayer.change_scene("res://scenes/ending.tscn")

func _ready():
	var tween = create_tween()
	tween.tween_property($Background/Text, "modulate:a",0,5)
