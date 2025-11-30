class_name ModificatorData
extends Object

var interval_: int = -1
var type_: String
var applyed_: bool = false
var used_: bool = false

var types: Array[String] = ["increase_mnX","decrease_width", "save_finger"]

var scoreMultiplier_ = 1
var widthCrease_ = 1
var lives_ = 0


func _init( type: String) -> void:
	type_ = type

func setInterval(i: int):
	interval_ = i

func apply():
	if interval_ != -1:
		if type_ == "increase_mnX":
			increase_mnX()
		elif type_ == "decrease_width":
			decrease_width()
		elif type_ == "save_finger":
			save_finger()
	
func increase_mnX():
	if applyed_ == false:
		scoreMultiplier_ = 2
	applyed_ = true
	
func decrease_width():
	if applyed_ == false:
		widthCrease_ *= 0.8 
	applyed_ = true
	
func save_finger():
	if applyed_ == false:
		lives_ += 1
	applyed_ = true
