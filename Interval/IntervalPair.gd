class_name IntervalPair
extends RefCounted

var data_: IntervalDataClass
var view_: IntervalViewClass

func _init(data: IntervalDataClass, view: IntervalViewClass) -> void:
	data_ = data
	view_ = view
