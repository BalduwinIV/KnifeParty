class_name IntervalDataClass
extends RefCounted

var start_: float
var end_: float
var center_: float
var width_: float # from 0.0 to 1.0
var height_: float
var color_: Color
var halfWidth_: float
var pathLength_: float
var widthPx_: float
var halfWidthPx_: float

var flyShow_: bool = false
var flyPos_: float = 0.0
var flyWidth_: float = 1.0
var flyHeight_: float = 7.5
var flyWidthPx_: float = 1.0
var flyHalfWidthPx_: float = 1.0
var flyColor_: Color = Color.BLUE
var lives_: int = 2
var maxedLives_: int = 2
var fullLivesColor_: Color = Color("ffa799")
var lowestLivesColor_: Color = Color.RED

var scoreMultiplier_: float = 1.0
var neutralScoreColor_: Color = Color.GREEN
var lowScoreColor_: Color = Color("#c22715")
var highScoreColor_: Color = Color("16c26a")
var inactiveDarknedValue: float = 0.5
#var neutralScoreColorInactive_: Color = Color.GRAY
#var lowScoreColorInactive_: Color = Color.DARK_GRAY
#var highScoreColorInactive_: Color = Color.LIGHT_GRAY
const LOW_BOUNDARY = 0.1
const HIGH_BOUNDARY = 10.0 


func _init(center: float, width: float, color: Color, pathLength: float, height: float):
	center_ = center
	width_ = width
	height_ = height
	halfWidth_ = width * 0.5
	start_ = center - halfWidth_
	end_ = center + halfWidth_
	color_ = color
	pathLength_ = pathLength
	widthPx_ = pathLength * width
	halfWidthPx_ = widthPx_ * 0.5

func recalculateInterval(start: float, end: float) -> void:
	start_ = start
	end_ = end
	center_ = (start + end) * 0.5
	width_ = end - start
	halfWidth_ = width_ * 0.5
	widthPx_ = pathLength_ * width_
	halfWidthPx_ = widthPx_ * 0.5

func recalculatePoint(center: float, width: float) -> void:
	center_ = center
	width_ = width
	halfWidth_ = width * 0.5
	start_ = center - halfWidth_
	end_ = center + halfWidth_
	widthPx_ = pathLength_ * width_
	halfWidthPx_ = widthPx_ * 0.5

func setUpFly(pos: float, width: float, color: Color) -> void:
	flyPos_ = pos
	flyWidth_ = width
	flyWidthPx_ = pathLength_ * width
	flyHalfWidthPx_ = flyWidthPx_ * 0.5
	flyColor_ = color
	flyShow_ = false

func checkFlyHit(hitPosAbs: float) -> bool:
	var flyHalfWidth = (flyWidth_ * 0.5)
	var flyStart = center_ - flyHalfWidth
	var flyEnd = center_ + flyHalfWidth
	if flyStart <= hitPosAbs and hitPosAbs <= flyEnd     :
		return true
	return false

func setScoreMultiplier(value: float):
	scoreMultiplier_ = value
	
func addScoreMultiplier(value: float):
	scoreMultiplier_ += value
	
func multScoreMultiplier(value: float):
	scoreMultiplier_ *= value

func getInterpolatedColor(active: bool) -> Color:
	if is_equal_approx(scoreMultiplier_, 1.0):
		if active:
			return neutralScoreColor_
		return neutralScoreColor_.darkened(inactiveDarknedValue)
	elif scoreMultiplier_ > 1.0:
		var factor = clamp((scoreMultiplier_ - 1.0) / (HIGH_BOUNDARY - 1.0), 0.0, 1.0)
		var finalColor = neutralScoreColor_.lerp(highScoreColor_, factor)
		if active:
			return finalColor
		return finalColor.darkened(inactiveDarknedValue)
	else: # scoreMultiplier_ < 1.0
		var factor = clamp((1.0 - scoreMultiplier_) / (1.0 - LOW_BOUNDARY), 0.0, 1.0)
		var finalColor = neutralScoreColor_.lerp(lowScoreColor_, factor)
		if active:
			return finalColor
		return finalColor.darkened(inactiveDarknedValue)

func updateFingerColor() -> void:
	var factor = clamp(lives_ / float(maxedLives_), 0.0, 1.0)
	color_ = lowestLivesColor_.lerp(fullLivesColor_, factor)
