extends Node

signal health_change

var is_game_over: bool = false

var health: int = 5:
	get:
		return health
	set(value):
		health = value
		health_change.emit()
		
func selectRandomLevelFromSet1() -> String:
	var rng = RandomNumberGenerator.new()
	var randint = rng.randi_range(1,3)
	var file_path = "res://scenes/levels/set1/easy_lvl_"+ str(randint) +".tscn"
	return file_path
	
func selectRandomLevelFromSet2() -> String:
	var rng = RandomNumberGenerator.new()
	var randint = rng.randi_range(1,3)
	var file_path = "res://scenes/levels/set2/med_lvl_"+ str(randint) +".tscn"
	return file_path
	
func selectRandomLevelFromSet3() -> String:
	var rng = RandomNumberGenerator.new()
	var randint = rng.randi_range(1,3)
	var file_path = "res://scenes/levels/set3/hard_lvl_"+ str(randint) +".tscn"
	return file_path
