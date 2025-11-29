class_name CursorDataClass
extends RefCounted

var pos_: float = 0.0
var width_: float
var height_: float
var widthPx_: float
var speed_: float = 1.0

func _init(pos: float) -> void:
	pos_ = pos
