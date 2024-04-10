extends BaseBot

@export var carryCapacity = 2
var storage = 0
var assignedDeposit : CoalDeposit

func start_work(deposit):
	assignedDeposit = deposit
	isAvailable = false
	state = MOVE

func move_state():
	super()
	moveTimer.start()

func move_to_deposit():
	await move(assignedDeposit.global_position)

func move_to_quarry():
	await move(buildingOwner.global_position)

func _on_move_timer_timeout():
	await move_to_deposit()
	storage += carryCapacity
	await get_tree().create_timer(3).timeout
	await move_to_quarry()
	interact_with_building.emit(storage)
	storage -= carryCapacity
	moveTimer.start()
