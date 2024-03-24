extends Area2D

signal playerTouched()

func _on_body_entered(body):
	if body.name == "Player":
		$WaitTimer.start()

func _on_body_exited(body):
	if body.name == "Player":
		$WaitTimer.stop()
	
func _on_wait_timer_timeout():
	playerTouched.emit()
