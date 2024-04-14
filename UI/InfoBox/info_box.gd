extends Node
class_name InfoBox

@export var interactHandler : Control

func _ready():
	interactHandler.toggled.connect(_on_interact_handler_toggled)

func _on_interact_handler_toggled(isOn):
	if isOn:
		self.visible = true
	else:
		self.visible = false
