extends Area2D

@onready var chargeTimer = $ChargeTimer
@onready var floatingParticles = $FloatingParticles
@onready var lineParticles = $LineParticles

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		self.global_position = get_global_mouse_position()
	
	if event.is_action_pressed("activate_energy"):
		switch_particles(true)
		chargeTimer.start()
	elif  event.is_action_released("activate_energy"):
		switch_particles(false)
		chargeTimer.stop()

func _on_charge_timer_timeout():
	var bots = self.get_overlapping_bodies()
	for bot in bots:
		bot.energyBar.charge(5)

func switch_particles(isOn : bool):
	floatingParticles.emitting = isOn
	lineParticles.emitting = isOn
