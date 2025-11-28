extends Path2D

@export var t: float = 0.0
@export_range(0.0, 1.0, 0.01) var fingerPos: float = 0.5
@export_range(0.0, 1.0, 0.01) var fingerWidth: float = 0.1

@export var cursorPathFollow: PathFollow2D;

var intervals: Array[IntervalDataClass]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pathLength = self.curve.get_baked_length()
	var i1 = IntervalDataClass.new(0, 0, 5, Color.GREEN, pathLength)
	var f1 = IntervalDataClass.new(fingerPos, fingerWidth, 10, Color.BLACK, pathLength)
	var i2 = IntervalDataClass.new(0, 0, 5, Color.GREEN, pathLength)
	
	i1.recalculateInterval(0.0, f1.start_)
	i2.recalculateInterval(f1.end_, 1.0)
	
	add_child(i1)
	add_child(f1)
	add_child(i2)
	
	intervals.append(i1)
	intervals.append(f1)
	intervals.append(i2)
	
	
func getInterval() -> IntervalDataClass:
	var tmpT = t
	for interval in intervals:
		if tmpT - interval.width_ < 0:
			return interval
		tmpT -= interval.width_
	return null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var interval = getInterval()
		interval.polygon_.color = Color.BLUE
	t += delta * 0.5
	if (t > 1.0):
		t -= 1.0
		for interval in intervals:
			interval.polygon_.color = interval.color_
	cursorPathFollow.progress_ratio = t
	intervals[1].recalculatePoint(fingerPos, fingerWidth)
	intervals[0].recalculateInterval(0.0, intervals[1].start_)
	intervals[2].recalculateInterval(intervals[1].end_, 1.0)
