extends TextureRect

signal dragging

func _get_drag_data(at_position):
	dragging.emit()
	return
