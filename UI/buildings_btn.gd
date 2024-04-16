extends TextureButton

@export var buildingScn : PackedScene

func _get_drag_data(at_position):
	
	var dragTexture = TextureRect.new()
	
	dragTexture.texture = texture_normal
	dragTexture.expand_mode = 1
	dragTexture.size = Vector2(30, 30)
	
	var preview = Control.new()
	preview.add_child(dragTexture)
	dragTexture.position = -0.5 * dragTexture.size
	
	set_drag_preview(preview)
	
	return buildingScn
