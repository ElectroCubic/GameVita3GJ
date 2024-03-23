extends Node2D

@onready var player = $Player

func _process(_delta):
	if Globals.health <= 0:
		player.death()
