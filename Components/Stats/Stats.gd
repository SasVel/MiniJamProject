extends Node
class_name Stats

@export var max_health = 20
var health = max_health : set = set_health

signal no_health
signal changed_health(val)

func set_health(val):
	emit_signal("changed_health", val)
	health = clamp(val, 0, max_health + 1)
	if health <= 0:
		emit_signal("no_health")

