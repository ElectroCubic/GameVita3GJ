extends Area2D

signal playerTouched

func _on_body_entered(body):
	if body.name == "Player":
		playerTouched.emit()
