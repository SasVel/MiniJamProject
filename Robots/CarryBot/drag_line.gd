extends Line2D

@onready var isDragging : bool : 
	set(val):
		if val: self.visible = true
		else: self.visible = false
		isDragging = val

func _ready():
	self.visible = false

func _process(delta):
	if isDragging:
		self.points[1] = get_local_mouse_position()

func _on_control_dragging():
	isDragging = true

func _notification(what):
	match what:
		NOTIFICATION_DRAG_END:
			isDragging = false
