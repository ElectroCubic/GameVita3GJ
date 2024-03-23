extends Node

signal health_change

var is_game_over: bool = false

var health: int = 5:
	get:
		return health
	set(value):
		health = value
		health_change.emit()
