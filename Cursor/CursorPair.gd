class_name CursorPairClass
extends RefCounted

var data_: CursorDataClass
var view_: CursorViewClass

func _init(data: CursorDataClass, view: CursorViewClass) -> void:
	data_ = data
	view_ = view
