extends TextureProgressBar

@export var maxEnergy = 10
@onready var energyInStorage = maxEnergy :
	set(val):
		energyInStorage = clamp(val, 0, maxEnergy)
		self.value = energyInStorage
		
		if val > 0:
			if energyTimer.is_stopped():
				gained_energy.emit()
				energyTimer.start()
		else:
			no_energy.emit()
			energyTimer.stop()
@export var energyLostPerTick : int = 1

@onready var defaultPosition : Vector2 = self.position
@onready var energyTimer = $EnergyTimer

signal gained_energy
signal no_energy

func offset(direction, speed):
	var tween = create_tween().set_parallel()
	tween.tween_property(self, "rotation", deg_to_rad((speed / 2) * -1) if direction.x > 0 else deg_to_rad((speed / 2)), 0.3)
	tween.tween_property(self, "position", defaultPosition + ((direction * speed) / 3 * -1), 0.3)

func reset_offset():
	var tween = create_tween().set_parallel()
	tween.tween_property(self, "rotation", deg_to_rad(0), 0.3)
	tween.tween_property(self, "position", defaultPosition, 0.2)

func _on_energy_timer_timeout():
	energyInStorage -= energyLostPerTick

func deplete(energy):
	energyInStorage -= energy

func charge(energy):
	energyInStorage += energy
