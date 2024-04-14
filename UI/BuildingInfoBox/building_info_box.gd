extends InfoBox

@onready var nameLabel = $MarginContainer/VBoxContainer/LabelBox/NameLabel

signal bot_color_changed(color)

func _ready():
	var building : BaseBuilding = self.owner
	nameLabel.text = building.buildingName

func _input(event):
	pass

func _on_color_picker_button_color_changed(color):
	bot_color_changed.emit(color)
