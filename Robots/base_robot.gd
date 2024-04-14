extends CharacterBody2D
class_name BaseBot

@export var SPEED : float = 20;
@export var wanderRange : float = 100;
@export var energyBar : TextureProgressBar
@onready var wanderTimer = $WanderTimer
@onready var moveTimer = $MoveTimer
@onready var sprites = $AnimatedSprite2D
@onready var warningMark = $WarningMark
var boundingRect : Rect2
var buildingOwner : StaticBody2D

var isAvailable = true
#Tweens
var moveTween : Tween

signal interact_with_building(val)
signal died

enum {
	IDLE,
	MOVE,
	WANDER,
	DISABLED
}

var state = IDLE : 
	set(val):
		lastState = state
		state = val
		change_state()

var lastState = IDLE

func init(buildingOwner_ : StaticBody2D, boundingRect_ : Rect2):
	buildingOwner = buildingOwner_
	boundingRect = boundingRect_

func _ready():
	energyBar.no_energy.connect(change_to_disabled_state)
	energyBar.gained_energy.connect(enable)

func change_state():
	match state:
		IDLE:
			idle_state()
		MOVE:
			move_state()
		WANDER:
			wander_state()
		DISABLED:
			disabled_state()

func idle_state():
	sprites.play("idle")
	
	energyBar.reset_offset()
	await get_tree().create_timer(2).timeout
	state = WANDER

func move_state():
	stop()
	pass

func wander_state():
	wanderTimer.start()

func wander():
	var xPos = randf_range(boundingRect.position.x,boundingRect.position.x + boundingRect.size.x)
	var yPos = randf_range(boundingRect.position.y, boundingRect.position.y + boundingRect.size.y)
	
	await move(Vector2(xPos, yPos))

func _on_wander_timer_timeout():
	await wander()
	wanderTimer.start()
	state = IDLE

func enable():
	var enableTween = create_tween()
	enableTween.tween_property(sprites, "speed_scale", 1, 0.5)
	state = lastState

func change_to_disabled_state():
	state = DISABLED

func disabled_state():
	sprites.play("idle")
	disable()

func disable():
	stop()
	var disableTween = create_tween()
	disableTween.tween_property(sprites, "speed_scale", 0, 0.5)

func move(target_pos : Vector2):
	sprites.play("walk")
	
	moveTween = create_tween()
	moveTween.tween_property(self, "position", target_pos, 25 / SPEED)
	
	#Sprite filp
	if position.x > target_pos.x:
		sprites.flip_h = true
	else:
		sprites.flip_h = false
	energyBar.offset(position.direction_to(target_pos), SPEED)
	
	await moveTween.finished

func stop():
	wanderTimer.stop()
	moveTimer.stop()
	if moveTween != null: moveTween.kill()

func set_color(color : Color):
	sprites.material.set_shader_parameter("replacedColor", color)

func _on_problem_check_timer_timeout():
	pass # Replace with function body.
