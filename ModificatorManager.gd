class_name ModificatorManager
extends Node

var data_: Array[ModificatorData] = []
var view_: ModificatorView = ModificatorView.new()

func _ready() -> void:
	var mod1 = ModificatorData.new("increase_pnX")
	var mod2 = ModificatorData.new("increase_mnX")
	var mod3 = ModificatorData.new("save_finger")
	data_.append(mod1)
	data_.append(mod2)
	data_.append(mod3)
	add_child(view_)

func apply():
	for m in data_:
		m.apply()
	view_.hideButtons()
	
func addModificator(m: ModificatorData):
	data_.append(m)
	
