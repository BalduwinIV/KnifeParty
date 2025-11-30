extends Node

var score: float = 0.0
@export var scoreBaseInc: float = 1.0
@export var mainLabel: Label
@export var font: Font
@export var popupOffsetY: float = 30.0
var activePopups: Array[Label] = []

func _ready() -> void:
	pass

func spawnScorePopup(value: float) -> void:
	var newPopup = Label.new()
	newPopup.text = ("+" if value >= 0 else "") + str(value)
	newPopup.label_settings = LabelSettings.new()
	newPopup.label_settings.font_size = 24
	newPopup.label_settings.outline_size = 3
	newPopup.label_settings.font = font
	var textSize = newPopup.get_minimum_size()
	newPopup.size = textSize
	newPopup.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	newPopup.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	newPopup.modulate = Color.YELLOW if value >= 0 else Color.RED
	newPopup.position.x = mainLabel.position.x + mainLabel.pivot_offset.x - textSize.x
	newPopup.position.y = mainLabel.position.y - popupOffsetY
	add_child(newPopup)
	activePopups.append(newPopup)
	updatePopupStack()

func updatePopupStack() -> void:
	for i in range(activePopups.size() - 1, -1, -1):
		var popup = activePopups[i]
		
		if not is_instance_valid(popup):
			activePopups.remove_at(i)
			continue
		
		var targetY = mainLabel.position.y + (i - (activePopups.size() - 1) - 1) * popupOffsetY
		var tween = create_tween()
		
		tween.tween_property(
			popup, "position:y", targetY, 0.15
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(
			popup, "modulate:a", 0.0, 1.0 
		)
		tween.tween_callback(Callable(popup, "queue_free"))
