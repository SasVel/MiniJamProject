extends Control

func _ready():
	GlobalData.drag_started.connect(drag_start)
	GlobalData.drag_stopped.connect(drag_stop)

func _can_drop_data(at_position, data):
	if data is PackedScene:
		return true
	return false

func _drop_data(at_position, data):
	var building = data.instantiate()
	building.global_position = get_global_mouse_position()
	Ref.buildingsFolder.add_child(building)
	
func drag_start():
	mouse_filter = MOUSE_FILTER_PASS

func drag_stop():
	mouse_filter = MOUSE_FILTER_IGNORE
