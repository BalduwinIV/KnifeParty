extends Path2D

@export var t: float = 0.0
@export var scoreLabel: Label;
var score: float = 0.0
var scoreStandartGain = 0.2

@export_range(0.0, 0.1, 0.0001) var cursorWidth: float = 0.01
@export_range(0.0, 30.0, 0.1) var cursorHeight: float = 15.0

# Finger 1
@export_range(0.0, 1.0, 0.0025) var f1Pos: float = 0.1
@export_range(0.0, 0.2, 0.001) var f1Width: float = 0.07

# Finger 2
@export_range(0.0, 1.0, 0.0025) var f2Pos: float = 0.3
@export_range(0.0, 0.2, 0.001) var f2Width: float = 0.05

# Finger 3
@export_range(0.0, 1.0, 0.0025) var f3Pos: float = 0.5
@export_range(0.0, 0.2, 0.001) var f3Width: float = 0.05     

# Finger 4
@export_range(0.0, 1.0, 0.0025) var f4Pos: float = 0.7
@export_range(0.0, 0.2, 0.001) var f4Width: float = 0.05     

# Finger 5
@export_range(0.0, 1.0, 0.0025) var f5Pos: float = 0.9
@export_range(0.0, 0.2, 0.001) var f5Width: float = 0.05

#@export var cursorPathFollow: PathFollow2D;
@export var cursorDir: float = 1.0

var intervals: Array[IntervalPair]
var cursor: CursorPairClass
var knifeCurve: KnifePath
var current_goal: int
var pattern1: Array[int] = [0, 2, 4, 0, 4, 6, 8, 0, 10]
var repetition: int = 0  

func prepareIntervals() -> void:
	var pathLength = self.curve.get_baked_length()
	knifeCurve = KnifePath.new()
	var cursorData = CursorDataClass.new(cursorWidth, cursorHeight, pathLength, Color.WHITE)
	var cursorView = CursorViewClass.new(cursorData)
	add_child(cursorView)
	cursor = CursorPairClass.new(cursorData, cursorView)
	
	var i1Data = IntervalDataClass.new(0, 0, Color.GRAY, pathLength)
	var f1Data = IntervalDataClass.new(f1Pos, f1Width, Color.BLACK, pathLength)
	var i2Data = IntervalDataClass.new(0, 0, Color.GRAY, pathLength)
	var f2Data = IntervalDataClass.new(f2Pos, f2Width, Color.BLACK, pathLength)
	var i3Data = IntervalDataClass.new(0, 0, Color.GRAY, pathLength)
	var f3Data = IntervalDataClass.new(f3Pos, f3Width, Color.BLACK, pathLength)
	var i4Data = IntervalDataClass.new(0, 0, Color.GRAY, pathLength)
	var f4Data = IntervalDataClass.new(f4Pos, f4Width, Color.BLACK, pathLength)
	var i5Data = IntervalDataClass.new(0, 0, Color.GRAY, pathLength)
	var f5Data = IntervalDataClass.new(f5Pos, f5Width, Color.BLACK, pathLength)
	var i6Data = IntervalDataClass.new(0, 0, Color.GRAY, pathLength)
	
	i1Data.recalculateInterval(0.0, f1Data.start_)
	i2Data.recalculateInterval(f1Data.end_, f2Data.start_)
	i3Data.recalculateInterval(f2Data.end_, f3Data.start_)
	i4Data.recalculateInterval(f3Data.end_, f4Data.start_)
	i5Data.recalculateInterval(f4Data.end_, f5Data.start_)
	i6Data.recalculateInterval(f5Data.end_, 1.0)
	
	var i1View = IntervalViewClass.new(i1Data)
	var f1View = IntervalViewClass.new(f1Data)
	var i2View = IntervalViewClass.new(i2Data)
	var f2View = IntervalViewClass.new(f2Data)
	var i3View = IntervalViewClass.new(i3Data)
	var f3View = IntervalViewClass.new(f3Data)
	var i4View = IntervalViewClass.new(i4Data)
	var f4View = IntervalViewClass.new(f4Data)
	var i5View = IntervalViewClass.new(i5Data)
	var f5View = IntervalViewClass.new(f5Data)
	var i6View = IntervalViewClass.new(i6Data)
	
	add_child(i1View)
	add_child(f1View)
	add_child(i2View)
	add_child(f2View)
	add_child(i3View)
	add_child(f3View)
	add_child(i4View)
	add_child(f4View)
	add_child(i5View)
	add_child(f5View)
	add_child(i6View)
	
	var i1 = IntervalPair.new(i1Data, i1View)
	var f1 = IntervalPair.new(f1Data, f1View)
	var i2 = IntervalPair.new(i2Data, i2View)
	var f2 = IntervalPair.new(f2Data, f2View)
	var i3 = IntervalPair.new(i3Data, i3View)
	var f3 = IntervalPair.new(f3Data, f3View)
	var i4 = IntervalPair.new(i4Data, i4View)
	var f4 = IntervalPair.new(f4Data, f4View)
	var i5 = IntervalPair.new(i5Data, i5View)
	var f5 = IntervalPair.new(f5Data, f5View)
	var i6 = IntervalPair.new(i6Data, i6View)
	
	intervals.append(i1)
	intervals.append(f1)
	intervals.append(i2)
	intervals.append(f2)
	intervals.append(i3)
	intervals.append(f3)
	intervals.append(i4)
	intervals.append(f4)
	intervals.append(i5)
	intervals.append(f5)
	intervals.append(i6)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prepareIntervals()
	current_goal = 0
	drawIntervals()
	$"../KnifeCurve/Path2D2/PathFollow2D".reposition(0)
	
	
func getInterval() -> int:
	var tmpT = cursor.data_.pos_
	for i in intervals.size():
		if tmpT - intervals[i].data_.width_ < 0:
			return i
		tmpT -= intervals[i].data_.width_
	return -1

func getOffsetInsideInterval() -> float:
	var tmpT = cursor.data_.pos_
	for i in intervals.size():
		if tmpT - intervals[i].data_.width_ < 0:
			return tmpT / intervals[i].data_.width_
		tmpT -= intervals[i].data_.width_
	return -1
	
func addScorePoints(dScore: float) -> void:
	score += dScore
	updateScoreLabel()

func updateScoreLabel() -> void:
	scoreLabel.text = str(score)
	
func redrawFinger(idx: int) -> void:
	intervals[idx].view_.redrawLeftPolygon(intervals[idx].data_.color_)
	intervals[idx].view_.redrawRightPolygon(intervals[idx].data_.color_)
	intervals[idx].view_.reposition()
	
func redrawInterval(idx: int) -> void:
	var leftColor: Color
	var rightColor: Color
	var isActive = idx == pattern1[current_goal]
	if idx > 0:
		leftColor = intervals[idx - 1].data_.getInterpolatedColor(isActive)
	else:
		leftColor = intervals[idx + 1].data_.getInterpolatedColor(isActive)
		
	if idx < intervals.size() - 1:
		rightColor = intervals[idx + 1].data_.getInterpolatedColor(isActive)
	else:
		rightColor = leftColor
	intervals[idx].view_.redrawLeftPolygon(leftColor)
	intervals[idx].view_.redrawRightPolygon(rightColor)
	intervals[idx].view_.reposition()

func drawIntervals() -> void:
	for i in range(intervals.size()):
		if i % 2:
			redrawFinger(i)
		else:
			redrawInterval(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	intervals[1].data_.recalculatePoint(f1Pos, f1Width)
	intervals[3].data_.recalculatePoint(f2Pos, f2Width)
	intervals[5].data_.recalculatePoint(f3Pos, f3Width)
	intervals[7].data_.recalculatePoint(f4Pos, f4Width)
	intervals[9].data_.recalculatePoint(f5Pos, f5Width)
	

	intervals[0].data_.recalculateInterval(0.0, intervals[1].data_.start_)
	intervals[2].data_.recalculateInterval(intervals[1].data_.end_, intervals[3].data_.start_)
	intervals[4].data_.recalculateInterval(intervals[3].data_.end_, intervals[5].data_.start_)
	intervals[6].data_.recalculateInterval(intervals[5].data_.end_, intervals[7].data_.start_)
	intervals[8].data_.recalculateInterval(intervals[7].data_.end_, intervals[9].data_.start_)
	intervals[10].data_.recalculateInterval(intervals[9].data_.end_, 1.0)
	
	if Input.is_action_just_pressed("ui_accept"):
		var idx = getInterval()
		if idx%2 == 0:
			$"../AudioKnifeInterval".play()
		else:
			$"../AudioKnifeFinger".play()
		if idx == pattern1[current_goal]:
			var offset = getOffsetInsideInterval()
			var scoreInc: float
			if (offset < 0.5):
				if (idx > 0):
					intervals[idx - 1].data_.addScoreMultiplier(scoreStandartGain)
					scoreInc = intervals[idx - 1].data_.scoreMultiplier_
				else:
					intervals[idx + 1].data_.addScoreMultiplier(scoreStandartGain)
					scoreInc = intervals[idx + 1].data_.scoreMultiplier_
			else:
				if (idx < intervals.size() - 1):
					intervals[idx + 1].data_.addScoreMultiplier(scoreStandartGain)
					scoreInc = intervals[idx + 1].data_.scoreMultiplier_
				else:
					intervals[idx - 1].data_.addScoreMultiplier(scoreStandartGain)
					scoreInc = intervals[idx - 1].data_.scoreMultiplier_
			addScorePoints(scoreInc)
			current_goal += 1
			if current_goal == pattern1.size():
				repetition +=1
				current_goal = 0
			
			if pattern1[current_goal] < idx:
				cursorDir = -1
			else:
				cursorDir = 1
	
	drawIntervals()
	
	cursor.data_.pos_ += cursorDir * delta * 0.5
	if (cursor.data_.pos_ > 1.0):
		cursor.data_.pos_ = 1.0
		cursorDir *= -1.0
	elif (cursor.data_.pos_ < 0.0):
		cursor.data_.pos_ = 0.0
		cursorDir *= -1.0
	
	cursor.view_.reposition()
	$"../KnifeCurve/Path2D3/PathFollow2D".reposition(cursor.data_.pos_)
