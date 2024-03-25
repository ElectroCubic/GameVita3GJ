extends CanvasLayer

signal restartPressed

@onready var healthText: Label = $HealthUI/HBoxContainer/HealthText

func _ready():
	Globals.connect("health_change", update_health_text)
	update_health_text()

func update_health_text():
	healthText.text = "X " + str(Globals.health)

func _on_restart_btn_pressed():
	$ClickSound.play()
	await $ClickSound.finished
	restartPressed.emit()

func _on_quit_btn_pressed():
	$ClickSound.play()
	await $ClickSound.finished
	get_tree().quit()

func _on_retry_btn_pressed():
	$ClickSound.play()
	await $ClickSound.finished
	get_tree().reload_current_scene()
