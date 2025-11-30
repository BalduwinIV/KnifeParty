class_name CursorDataClass
extends RefCounted

var pos_: float = 0.0
var width_: float
var height_: float
var widthPx_: float
var halfWidthPx_: float
var pathLength_: float
var speed_: float = 0.3 
var minSpeed_: float = 0.3
var maxSpeed_: float = 0.3
var speedDetectionRange: float = 0.2
var color_: Color

func _init(width: float, height: float, pathLength: float, color: Color) -> void:
	width_ = width
	height_ = height
	pathLength_ = pathLength
	color_ = color
	widthPx_ = pathLength * width
	halfWidthPx_ = widthPx_ * 0.5

func recalculate(width: float) -> void:
	width_ = width
	widthPx_ = pathLength_ * width
	halfWidthPx_ = widthPx_ * 0.5
