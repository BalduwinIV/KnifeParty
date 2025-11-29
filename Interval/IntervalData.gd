class_name IntervalDataClass
extends RefCounted

var start_: float
var end_: float
var center_: float
var width_: float # from 0.0 to 1.0
var height_: float = 10
var color_: Color
var halfWidth_: float
var pathLength_: float
var widthPx_: float


func _init(center: float, width: float, color: Color, pathLength: float):
	center_ = center
	width_ = width
	halfWidth_ = width * 0.5
	start_ = center - halfWidth_
	end_ = center + halfWidth_
	color_ = color
	pathLength_ = pathLength
	widthPx_ = pathLength * width

func recalculateInterval(start: float, end: float) -> void:
	start_ = start
	end_ = end
	center_ = (start + end) * 0.5
	width_ = end - start
	halfWidth_ = width_ * 0.5
	widthPx_ = pathLength_ * width_

func recalculatePoint(center: float, width: float) -> void:
	center_ = center
	width_ = width
	halfWidth_ = width * 0.5
	start_ = center - halfWidth_
	end_ = center + halfWidth_
	widthPx_ = pathLength_ * width_
