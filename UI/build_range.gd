extends Control

func _can_drop_data(at_position, data):
	if data is PackedScene:
		return true
	return false

func _drop_data(at_position, data):
	var building = data.instantiate()
	building.global_position = get_global_mouse_position()
	Ref.buildingsFolder.add_child(building)
	
