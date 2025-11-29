class_name CursorViewClass
extends PathFollow2D

var cursorData_: CursorDataClass
var polygon_: Polygon2D
var polygonPoints_: PackedVector2Array

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
