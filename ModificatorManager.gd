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

func randomlyChooseInterval(type: String) -> int:
	var choice
	if type == "decrease_width" || type == "save_finger":
		var arr = [1, 3, 5, 7, 9]
		choice = arr[randi() % arr.size()]
	if type == "increase_mnX":
		var arr = [0, 2, 4, 6, 8, 10]
		choice = arr[randi() % arr.size()]
	return choice
	
func apply():
	for m in data_:
		m.apply()
	
func _process(delta: float) -> void:
	if view_.newModType != "":
		var m = ModificatorData.new(view_.newModType)
		var i = randomlyChooseInterval(view_.newModType)
		m.setInterval(i)
		addModificator(m)
		view_.newModType = ""
		mustHide = true
		
		
	
