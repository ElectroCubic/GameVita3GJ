extends Node2D

@onready var player = $Player

func restartLevel():
	checkHealth()
	Globals.is_game_over = false
	get_tree().reload_current_scene()

func checkHealth():
	if Globals.health <= 0:
		Globals.is_game_over = true
		print("Actual game over")
		get_tree().quit()

func _on_player_collided(collision):
	if collision.get_collider() is TileMap:
		var tile_pos = collision.get_collider().local_to_map(player.position)
		tile_pos = tile_pos - Vector2i(collision.get_normal())
		
		var tile_under_pos = tile_pos + Vector2i(0,1)
		var tile_above_pos = tile_pos - Vector2i(0,1)
		var tile_under_data = collision.get_collider().get_cell_tile_data(0,tile_under_pos)
		var tile_above_data = collision.get_collider().get_cell_tile_data(0,tile_above_pos)
				
		if not (tile_under_data == null) and tile_under_pos:
			var custom_under_data = tile_under_data.get_custom_data_by_layer_id(0)
			if custom_under_data == 2 and not Globals.is_game_over:
				player.death()
			
		if not (tile_above_data == null) and tile_above_pos:
			var custom_above_data = tile_above_data.get_custom_data_by_layer_id(0)
			if custom_above_data == 2 and not Globals.is_game_over:
				player.death()

func _on_ui_restart_pressed():
	Globals.is_game_over = false
	print("Restarted")
	
func _on_exit_door_player_touched():
	print("level complete!")

func _on_player_player_died():
	restartLevel()
