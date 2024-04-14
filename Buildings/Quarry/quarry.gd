extends BaseBuilding
class_name Quarry

@export var coalCapacity = 10
@onready var coalInStorage = 0 :
	set(val):
		coalInStorage = clamp(val, 0, coalCapacity)
		infoLabel.update(str(coalInStorage) + "/" + str(coalCapacity))

var deposits : Array[Node2D]

func check_for_deposits():
	deposits = rangeArea.get_overlapping_bodies()

func _on_assign_timer_timeout():
	check_for_deposits()
	for deposit in deposits:
		if deposit.assignedBots < deposit.botCapacity:
			if currBots.size() == 0: return
			
			var bots = currBots.filter(func(bot): return bot.isAvailable)
			if bots.size() != 0:
				deposit.assignedBots += 1
				bots[0].start_work(deposit)

func bot_interact(val):
	coalInStorage += val
