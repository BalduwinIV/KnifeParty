class_name IntervalDataClass
extends PathFollow2D

@export var start_: float
@export var end_: float
@export var center_: float
@export var width_: float # from 0.0 to 1.0
@export var height_: float
@export var color_: Color
var halfWidth_: float
@export var polygon_: Polygon2D
var polygonPoints_: PackedVector2Array
var pathLength_: float

func _init(center: float, width: float, height: float, color: Color, pathLength: float) -> void:
	center_ = center
	width_ = width
	height_ = height
	halfWidth_ = width * 0.5
	start_ = center - halfWidth_
	end_ = center + halfWidth_
	color_ = color
	pathLength_ = pathLength
	var widthPx = pathLength * width * 0.5
	polygon_ = Polygon2D.new()
	polygon_.visible = true
	polygonPoints_ = PackedVector2Array()
	polygonPoints_.append(Vector2(-widthPx, -height_))
	polygonPoints_.append(Vector2(widthPx, -height_))
	polygonPoints_.append(Vector2(widthPx, height_))
	polygonPoints_.append(Vector2(-widthPx, height_))
	polygon_.polygon = polygonPoints_
	polygon_.color = color_
	add_child(polygon_)

func recalculateInterval(start: float, end: float) -> void:
	start_ = start
	end_ = end
	center_ = (start + end) * 0.5
	width_ = end - start
	halfWidth_ = width_ * 0.5
	var widthPx = pathLength_ * width_ * 0.5
	polygonPoints_ = PackedVector2Array()
	polygonPoints_.append(Vector2(-widthPx, -height_))
	polygonPoints_.append(Vector2(widthPx, -height_))
	polygonPoints_.append(Vector2(widthPx, height_))
	polygonPoints_.append(Vector2(-widthPx, height_))
	polygon_.polygon = polygonPoints_
	
	reposition()
	
func recalculatePoint(center: float, width: float) -> void:
	center_ = center
	width_ = width
	halfWidth_ = width * 0.5
	start_ = center - halfWidth_
	end_ = center + halfWidth_
	var widthPx = pathLength_ * width_ * 0.5
	polygonPoints_ = PackedVector2Array()
	polygonPoints_.append(Vector2(-widthPx, -height_))
	polygonPoints_.append(Vector2(widthPx, -height_))
	polygonPoints_.append(Vector2(widthPx, height_))
	polygonPoints_.append(Vector2(-widthPx, height_))
	polygon_.polygon = polygonPoints_
	
	reposition()

func reposition() -> void:
	progress_ratio = center_
