extends Line2D

@onready var isDragging : bool

func _on_control_dragging():
	isDragging = true

func _process(delta):
	if isDragging:
		self.points[1] = get_local_mouse_position()

func _notification(what):
	match what:
		NOTIFICATION_DRAG_END:
			print("end")
			isDragging = false
