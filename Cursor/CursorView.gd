class_name CursorViewClass
extends PathFollow2D

var cursorData_: CursorDataClass
var polygon_: Polygon2D
var polygonPoints_: PackedVector2Array

var animationTween: Tween = null
var animationDuration: float = 0.03

func _init(cursorData: CursorDataClass) -> void:
	cursorData_ = cursorData
	initPolygonPoints()
	createPolygon()
	reposition()
	
func initPolygonPoints():
	polygonPoints_ = PackedVector2Array()
	polygonPoints_.append(Vector2(-cursorData_.halfWidthPx_, -cursorData_.height_))
	polygonPoints_.append(Vector2(cursorData_.halfWidthPx_, -cursorData_.height_))
	polygonPoints_.append(Vector2(cursorData_.halfWidthPx_, cursorData_.height_))
	polygonPoints_.append(Vector2(-cursorData_.halfWidthPx_, cursorData_.height_))

func redrawPolygon():
	polygonPoints_[0] = Vector2(-cursorData_.halfWidthPx_, -cursorData_.height_)
	polygonPoints_[1] = Vector2(cursorData_.halfWidthPx_, -cursorData_.height_)
	polygonPoints_[2] = Vector2(cursorData_.halfWidthPx_, cursorData_.height_)
	polygonPoints_[3] = Vector2(-cursorData_.halfWidthPx_, cursorData_.height_)
	polygon_.polygon = polygonPoints_
	polygon_.color = cursorData_.color_
	polygon_.z_index = 1

func createPolygon():
	polygon_ = Polygon2D.new()
	polygon_.visible = true
	redrawPolygon()
	add_child(polygon_)

func reposition() -> void:
	progress_ratio = cursorData_.pos_

func start_animation() -> void:
	if animationTween and animationTween.is_valid():
		animationTween.kill()
	
	animationTween = create_tween()
	animationTween.tween_property(
		polygon_, "scale", Vector2(1.0, 0.5), animationDuration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	animationTween.tween_property(
		polygon_, "scale", Vector2(1.0, 1.0), animationDuration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	animationTween.connect("finished", Callable(self, "onAnimationFinished"))
	
func onAnimationFinished():
	pass
