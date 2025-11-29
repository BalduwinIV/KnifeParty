class_name IntervalViewClass
extends PathFollow2D

var int_data_: IntervalDataClass
var polygon_: Polygon2D
var polygonPoints_: PackedVector2Array

var polygonLeft_: Polygon2D
var polygonLeftPoints_: PackedVector2Array
var polygonRight_: Polygon2D
var polygonRightPoints_: PackedVector2Array

var polygonCenter_: Polygon2D
var polygonCenterPoints_: PackedVector2Array

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

#func redrawPolygon():
	#var widthPx = int_data_.pathLength_ * int_data_.width_ * 0.5
	#polygonPoints_ = PackedVector2Array()
	#polygonPoints_.append(Vector2(-widthPx, -int_data_.height_))
	#polygonPoints_.append(Vector2(widthPx, -int_data_.height_))
	#polygonPoints_.append(Vector2(widthPx, int_data_.height_))
	#polygonPoints_.append(Vector2(-widthPx, int_data_.height_))
	#polygon_.polygon = polygonPoints_
	#polygon_.color = int_data_.color_
	
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

func reposition() -> void:
	progress_ratio = int_data_.center_

func _init(interval_data: IntervalDataClass):
	int_data_ = interval_data
	initPolygonPoints()
	#createPolygon()
	createLeftPolygon()
	createRightPolygon()
	reposition()
