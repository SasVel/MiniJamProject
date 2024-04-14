extends BaseBot

@onready var assignedBuilding : BaseBuilding

func start_work(building):
	assignedBuilding = building
	isAvailable = false
	state = MOVE

func move_state():
	super()
	moveTimer.start()

func move_to_building():
	await move(assignedBuilding.global_position)

func move_to_station():
	await move(buildingOwner.global_position)

func move_to_generator():
	await move(GlobalData.generatorPos)

func _on_move_timer_timeout():
	await move_to_building()
	await get_tree().create_timer(2).timeout
	await move_to_station()
	await get_tree().create_timer(2).timeout
	await move_to_generator()
	moveTimer.start()

func _on_problem_check_timer_timeout():
	if assignedBuilding == null:
		warningMark.visible = true
	else:
		warningMark.visible = false
