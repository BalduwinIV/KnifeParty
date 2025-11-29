class_name IntervalViewClass
extends PathFollow2D

var int_data_: IntervalDataClass
var polygon_: Polygon2D
var polygonPoints_: PackedVector2Array

func redrawPolygon():
	var widthPx = int_data_.pathLength_ * int_data_.width_ * 0.5
	polygonPoints_ = PackedVector2Array()
	polygonPoints_.append(Vector2(-widthPx, -int_data_.height_))
	polygonPoints_.append(Vector2(widthPx, -int_data_.height_))
	polygonPoints_.append(Vector2(widthPx, int_data_.height_))
	polygonPoints_.append(Vector2(-widthPx, int_data_.height_))
	polygon_.polygon = polygonPoints_
	polygon_.color = int_data_.color_

func createPolygon():
	polygon_ = Polygon2D.new()
	polygon_.visible = true
	redrawPolygon()
	add_child(polygon_)

func reposition() -> void:
	progress_ratio = int_data_.center_

func _init(interval_data: IntervalDataClass):
	int_data_ = interval_data
	createPolygon()
	reposition()
