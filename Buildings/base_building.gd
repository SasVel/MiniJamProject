extends StaticBody2D
class_name BaseBuilding

@export var maxBots : int = 5
var currBots : Array[BaseBot]
@export var botToSpawnScn : PackedScene
@onready var spawnTimer = $SpawnTimer
@onready var rangeArea = $RangeArea
@onready var rangeAreaShape : CollisionShape2D = $RangeArea/CollisionShape2D
@onready var infoLabel = $InfoLabel

func _on_spawn_timer_timeout():
	var botInst : BaseBot = botToSpawnScn.instantiate()
	var r = rangeAreaShape.shape.get_rect()
	botInst.init(self, Rect2(to_global(r.position), r.size))
	botInst.died.connect(on_bot_death)
	botInst.interact_with_building.connect(bot_interact)
	botInst.global_position = self.global_position
	Ref.botsFolder.add_child(botInst)
	currBots.push_back(botInst)
	if maxBots == currBots.size():
		spawnTimer.stop()

func bot_interact(val):
	pass

func on_bot_death(bot):
	currBots.erase(bot)
	spawnTimer.start()