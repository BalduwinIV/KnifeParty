class_name IntervalViewClass
extends PathFollow2D

var int_data_: IntervalDataClass
var polygon_: Polygon2D
var polygonPoints_: PackedVector2Array

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
	polygonFlyPoints_[0] = Vector2(-int_data_.flyHalfWidthPx_, -int_data_.height_)
	polygonFlyPoints_[1] = Vector2(int_data_.flyHalfWidthPx_, -int_data_.height_)
	polygonFlyPoints_[2] = Vector2(int_data_.flyHalfWidthPx_, int_data_.height_)
	polygonFlyPoints_[3] = Vector2(-int_data_.flyHalfWidthPx_, int_data_.height_)
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
	add_child(polygonFly_)

func createLeftPolygon():
	polygonLeft_ = Polygon2D.new()
	polygonLeft_.visible = true
	redrawLeftPolygon(int_data_.color_)
	add_child(polygonLeft_)
	
func createRightPolygon():
	polygonRight_ = Polygon2D.new()
	polygonRight_.visible = true
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
