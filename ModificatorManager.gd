class_name ModificatorManager
extends Node

var data_: Array[ModificatorData] = []
var view_: ModificatorView = ModificatorView.new()
var mustHide: bool = false

func _ready() -> void:
	var mod1 = ModificatorData.new("decrease_width")
	var mod2 = ModificatorData.new("increase_mnX")
	var mod3 = ModificatorData.new("save_finger")
	addModificator(mod1)
	addModificator(mod2)
	addModificator(mod3)
	add_child(view_)

func showModificators() -> int:
	view_.showButtons()
	return 0
	
func addModificator(m: ModificatorData):
	m.setInterval(1)
	data_.append(m)
	
	
func _process(delta: float) -> void:
	if view_.newModType != "":
		var m = ModificatorData.new(view_.newModType)
		addModificator(m)
		view_.newModType = ""
		mustHide = true
		
		
	
