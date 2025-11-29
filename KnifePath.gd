class_name KnifePath
extends PathFollow2D


var speed := 0.2
var base_y := 0.0
var is_jumping := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_y = position.y  # запоминаем исходную высоту

func reposition(t: float) -> void:
	progress_ratio = t 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("jump"):
		jump()

	
func jump():
	if is_jumping:
		return
	is_jumping = true
	var tween = create_tween()
	tween.tween_property(self, "position:y", base_y + 50, 0.1).as_relative() # быстро вниз
	tween.tween_property(self, "position:y", base_y, 0.2) # назад вверх
	tween.finished.connect(_on_jump_finished)

func _on_jump_finished():
	is_jumping = false
