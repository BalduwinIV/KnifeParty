class_name ModificatorData
extends Object

var interval_: IntervalDataClass = null
var type_: String
var applyed_: bool = false

var types: Array[String] = ["increase_pnX","increase_mnX", "save_finger"]


func _init( type: String) -> void:
	type_ = type

func setInterval(i: IntervalDataClass):
	interval_ = i

func apply():
	if interval_ != null:
		if type_ == "increase_mnX":
			increase_mnX()
		elif type_ == "increase_pnX":
			increase_pnX()
		elif type_ == "save_finger":
			save_finger()
	
func increase_mnX():
	interval_.scoreMultiplier_ = 500
	
func increase_pnX():
	interval_.scoreMultiplier_ = 1000
	
func save_finger():
	if applyed_ == false:
		interval_.lives_ += 1
	applyed_ = true
