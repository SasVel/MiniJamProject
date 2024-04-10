extends Area2D

@onready var chargeTimer = $ChargeTimer

func _input(event):
	if event is InputEventMouseMotion:
		self.global_position = get_global_mouse_position()
	
	if event.is_action_pressed("activate_energy"):
		chargeTimer.start()
	elif  event.is_action_released("activate_energy"):
		chargeTimer.stop()

func _on_charge_timer_timeout():
	var bots = self.get_overlapping_bodies()
	for bot in bots:
		bot.energyBar.charge(5)
