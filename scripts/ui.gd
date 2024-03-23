extends CanvasLayer

@onready var healthText: Label = $HealthUI/HBoxContainer/HealthText

func _ready():
	Globals.connect("health_change", update_health_text)
	update_health_text()

func update_health_text():
	healthText.text = "X " + str(Globals.health)

