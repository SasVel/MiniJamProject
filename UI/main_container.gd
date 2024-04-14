extends Control

func _notification(what):
	match what:
		NOTIFICATION_DRAG_END:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
