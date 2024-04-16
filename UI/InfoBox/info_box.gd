extends Node
class_name InfoBox

@export var interactHandler : Control
@onready var closeTimer : Timer = $CloseTimer

func _ready():
	interactHandler.toggled.connect(_on_interact_handler_toggled)
	closeTimer.timeout.connect(close)
	self.visible = false

func _on_interact_handler_toggled(isOn):
	if isOn:
		open()
	else:
		close()

func open():
	closeTimer.start()
	self.visible = true

func close():
	self.visible = false
