extends Button

func _can_drop_data(at_position, data):
	if owner is Quarry:
		return true
	return false

func _drop_data(at_position, data):
	var bot = data
	bot.start_work(owner)
