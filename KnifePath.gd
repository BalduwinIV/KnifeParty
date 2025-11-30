class_name KnifePath
extends PathFollow2D
var isAnimated: bool = false
var start_offset := 0.0
var end_offset := 150.0   


func animate():
	if isAnimated: return
	isAnimated = true
	var tween = create_tween()

	tween.tween_property(self, "v_offset", end_offset, 0.05)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(self, "v_offset", start_offset, 0.07)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.finished.connect(func():
		isAnimated = false
	)
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		animate()

func reposition(t: float) -> void:
	progress_ratio = t 
	
