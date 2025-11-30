class_name ModificatorManager
extends Node

var data_: Array[ModificatorData] = []
var view_: ModificatorView = ModificatorView.new()
var mustHide: bool = false
var isAvailable: bool = false

func _ready() -> void:
	add_child(view_)

func showModificators():
	if isAvailable == false:
		view_.showButtons()
		isAvailable = true
	
func addModificator(m: ModificatorData):
	data_.append(m)

func chooseInterval(type: String) -> int:
	var choice
	if type == "decrease_width":
		choice = view_.i1
	elif type == "increase_mnX":
		choice = view_.i2
	elif type == "save_finger":
		choice = view_.i3
	return choice
	
func apply():
	for m in data_:
		m.apply()
	
func _process(delta: float) -> void:
	if view_.newModType != "":
		var m = ModificatorData.new(view_.newModType)
		var i = chooseInterval(view_.newModType)
		view_.newModType = ""
		m.setInterval(i)
		addModificator(m)
		mustHide = true
		isAvailable = false
		
		
	
