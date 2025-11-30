class_name IntervalViewClass
extends PathFollow2D

var int_data_: IntervalDataClass
var polygon_: Polygon2D
var polygonPoints_: PackedVector2Array

var DIESEL_MAT = preload("res://resources/materials/diesel.tres")

var polygonLeft_: Polygon2D
var polygonLeftPoints_: PackedVector2Array
var polygonRight_: Polygon2D
var polygonRightPoints_: PackedVector2Array

var polygonFly_: Polygon2D
var polygonFlyPoints_: PackedVector2Array 

var polygonLeftAnimationTween: Tween = null
var polygonLeftAnimationDuration: float = 0.1
var polygonRightAnimationTween: Tween = null
var polygonRightAnimationDuration: float = 0.1
var polygonFlyAnimationTween: Tween = null
var polygonFlyAnimationDuration: float = 0.1
var flyAnimationInProcess_: bool = false

var animationMovementAmountY: float = 10.0
var animationBounceOverheadY: float = 2.0
var animationFingerPulseColor: Color = Color.RED
var animationFingerPulseStrength: float = 0.5
var animationFingerMoveDuration: float = 0.05
var animationFingerPulseDuration: float = 0.1
var animationFingerBounceDuration: float = 0.05


 

func initPolygonPoints():
	polygonLeftPoints_ = PackedVector2Array()
	polygonLeftPoints_.append(Vector2(-int_data_.halfWidthPx_, -int_data_.height_))
	polygonLeftPoints_.append(Vector2(0.0, -int_data_.height_))
	polygonLeftPoints_.append(Vector2(0.0, int_data_.height_))
	polygonLeftPoints_.append(Vector2(-int_data_.halfWidthPx_, int_data_.height_))
	
	polygonRightPoints_ = PackedVector2Array()
	polygonRightPoints_.append(Vector2(0.0, -int_data_.height_))
	polygonRightPoints_.append(Vector2(int_data_.halfWidthPx_, -int_data_.height_))
	polygonRightPoints_.append(Vector2(int_data_.halfWidthPx_, int_data_.height_))
	polygonRightPoints_.append(Vector2(0.0, int_data_.height_))
	
	polygonFlyPoints_ = PackedVector2Array()
	polygonFlyPoints_.append(Vector2(0, 0))
	polygonFlyPoints_.append(Vector2(0, 0))
	polygonFlyPoints_.append(Vector2(0, 0))
	polygonFlyPoints_.append(Vector2(0, 0))
	
func drawFly():
	polygonFlyPoints_[0] = Vector2(-int_data_.flyHalfWidthPx_, -int_data_.flyHeight_)
	polygonFlyPoints_[1] = Vector2(int_data_.flyHalfWidthPx_, -int_data_.flyHeight_)
	polygonFlyPoints_[2] = Vector2(int_data_.flyHalfWidthPx_, int_data_.flyHeight_)
	polygonFlyPoints_[3] = Vector2(-int_data_.flyHalfWidthPx_, int_data_.flyHeight_)
	polygonFly_.polygon = polygonFlyPoints_
	polygonFly_.color = int_data_.flyColor_
	polygonFly_.visible = true
	int_data_.flyShow_ = true

func hideFly():
	polygonFly_.visible = false
	int_data_.flyShow_ = false
	
func redrawLeftPolygon(color: Color):
	polygonLeftPoints_[0] = Vector2(-int_data_.halfWidthPx_, -int_data_.height_)
	polygonLeftPoints_[1] = Vector2(0.0, -int_data_.height_)
	polygonLeftPoints_[2] = Vector2(0.0, int_data_.height_)
	polygonLeftPoints_[3] = Vector2(-int_data_.halfWidthPx_, int_data_.height_)
	polygonLeft_.polygon = polygonLeftPoints_
	polygonLeft_.color = color

func redrawRightPolygon(color: Color):
	polygonRightPoints_[0] = Vector2(0.0, -int_data_.height_)
	polygonRightPoints_[1] = Vector2(int_data_.halfWidthPx_, -int_data_.height_)
	polygonRightPoints_[2] = Vector2(int_data_.halfWidthPx_, int_data_.height_)
	polygonRightPoints_[3] = Vector2(0.0, int_data_.height_)
	polygonRight_.polygon = polygonRightPoints_
	polygonRight_.color = color
	
func createFlyPolygon():
	polygonFly_ = Polygon2D.new()
	polygonFly_.visible = false
	polygonFly_.material = DIESEL_MAT.duplicate()
	add_child(polygonFly_)

func createLeftPolygon():
	polygonLeft_ = Polygon2D.new()
	polygonLeft_.visible = true
	polygonLeft_.material = DIESEL_MAT.duplicate()
	redrawLeftPolygon(int_data_.color_)
	add_child(polygonLeft_)
	
func createRightPolygon():
	polygonRight_ = Polygon2D.new()
	polygonRight_.visible = true
	polygonRight_.material = DIESEL_MAT.duplicate()
	redrawRightPolygon(int_data_.color_)
	add_child(polygonRight_)

#func createPolygon():
	#polygon_ = Polygon2D.new()
	#polygon_.visible = true
	#redrawPolygon()
	#add_child(polygon_)
	
func startAnimationLeft() -> void:
	if polygonLeftAnimationTween and polygonLeftAnimationTween.is_valid():
		polygonLeftAnimationTween.kill()
	
	polygonLeftAnimationTween = create_tween()
	polygonLeftAnimationTween.tween_property(
		polygonLeft_, "scale", Vector2(1.0, 1.5), polygonLeftAnimationDuration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	polygonLeftAnimationTween.tween_property(
		polygonLeft_, "scale", Vector2(1.0, 1.0), polygonLeftAnimationDuration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	polygonLeftAnimationTween.connect("finished", Callable(self, "onAnimationFinished"))
	
func startAnimationRight() -> void:
	if polygonRightAnimationTween and polygonRightAnimationTween.is_valid():
		polygonRightAnimationTween.kill()
	
	polygonRightAnimationTween = create_tween()
	polygonRightAnimationTween.tween_property(
		polygonRight_, "scale", Vector2(1.0, 1.5), polygonRightAnimationDuration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	polygonRightAnimationTween.tween_property(
		polygonRight_, "scale", Vector2(1.0, 1.0), polygonRightAnimationDuration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	polygonRightAnimationTween.connect("finished", Callable(self, "onAnimationFinished"))

func startAnimationFly() -> void:
	if polygonFlyAnimationTween and polygonFlyAnimationTween.is_valid():
		polygonFlyAnimationTween.kill()
	
	flyAnimationInProcess_ = true
	polygonFlyAnimationTween = create_tween()
	polygonFlyAnimationTween.tween_property(
		polygonFly_, "scale", Vector2(1.0, 1.5), polygonFlyAnimationDuration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	polygonFlyAnimationTween.tween_property(
		polygonFly_, "scale", Vector2(1.0, 1.0), polygonFlyAnimationDuration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	polygonFlyAnimationTween.connect("finished", Callable(self, "onAnimationFlyFinished"))
	
func startFingerAnimation() -> void:
	if polygonRightAnimationTween and polygonRightAnimationTween.is_valid():
		polygonRightAnimationTween.kill()
	if polygonLeftAnimationTween and polygonLeftAnimationTween.is_valid():
		polygonLeftAnimationTween.kill()
		
	var matR = polygonRight_.material as ShaderMaterial
	var matL = polygonLeft_.material as ShaderMaterial
	var jitterSpeed = randf_range(0.0, 10.0)
	var jitterAmount = randf_range(1.0, 5.0)
	matR.set_shader_parameter("jitter_speed", 10 * (int_data_.maxedLives_ - int_data_.lives_ + 1) + jitterSpeed)
	matR.set_shader_parameter("jitter_amount", jitterAmount)
	matL.set_shader_parameter("jitter_speed", 10 * (int_data_.maxedLives_ - int_data_.lives_ + 1) + jitterSpeed)
	matL.set_shader_parameter("jitter_amount", jitterAmount)
	
	polygonLeftAnimationTween = create_tween()
	polygonRightAnimationTween = create_tween()
	
	var startY = 0
	var yTop = -animationMovementAmountY
	var yBottom = animationMovementAmountY
	
	var colorLeftTween = create_tween()
	var colorRightTween = create_tween()
	
	pulse_color_tween(colorLeftTween, polygonLeft_, animationFingerPulseColor, animationFingerPulseDuration, 2)
	pulse_color_tween(colorRightTween, polygonRight_, animationFingerPulseColor, animationFingerPulseDuration, 2)
	
	polygonLeftAnimationTween.tween_property(polygonLeft_, "position:y", yBottom, animationFingerMoveDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	polygonRightAnimationTween.tween_property(polygonRight_, "position:y", yBottom, animationFingerMoveDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	polygonLeftAnimationTween.tween_property(polygonLeft_, "position:y", yTop, animationFingerMoveDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	polygonRightAnimationTween.tween_property(polygonRight_, "position:y", yTop, animationFingerMoveDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	polygonLeftAnimationTween.tween_property(polygonLeft_, "position:y", startY + animationBounceOverheadY, animationFingerBounceDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	polygonRightAnimationTween.tween_property(polygonRight_, "position:y", startY + animationBounceOverheadY, animationFingerBounceDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	polygonLeftAnimationTween.tween_property(polygonLeft_, "position:y", startY - animationBounceOverheadY, animationFingerBounceDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	polygonRightAnimationTween.tween_property(polygonRight_, "position:y", startY - animationBounceOverheadY, animationFingerBounceDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# Then, spring back to the original position
	polygonLeftAnimationTween.tween_property(polygonLeft_, "position:y", startY, animationFingerBounceDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	polygonRightAnimationTween.tween_property(polygonRight_, "position:y", startY, animationFingerBounceDuration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# --- Final Cleanup ---
	polygonLeftAnimationTween.connect("finished", Callable(self, "_on_complex_animation_finished"))
	polygonRightAnimationTween.connect("finished", Callable(self, "_on_complex_animation_finished"))

# Helper function to chain color pulses onto a tween
func pulse_color_tween(tween: Tween, polygon: Polygon2D, color_to_tint: Color, duration_per_half: float, num_pulses: int):
	# Calculate the tinted color
	var tinted_color = int_data_.color_.lerp(color_to_tint, animationFingerPulseStrength)
	
	for i in range(num_pulses):
		# Tint In
		tween.tween_property(polygon, "modulate", tinted_color, duration_per_half).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		# Tint Out (back to original color)
		tween.tween_property(polygon, "modulate", int_data_.color_, duration_per_half).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	
func onAnimationFlyFinished():
	hideFly()
	flyAnimationInProcess_ = false

func reposition() -> void:
	progress_ratio = int_data_.center_

func _init(interval_data: IntervalDataClass):
	int_data_ = interval_data
	initPolygonPoints()
	createLeftPolygon()
	createRightPolygon()
	createFlyPolygon()
	reposition()
