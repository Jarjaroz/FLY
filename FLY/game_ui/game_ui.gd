extends Control

@onready var time_label = $MarginContainer/VBoxContainer/timeLabel
@onready var timer = $Timer
@onready var height_label = $MarginContainer/VBoxContainer/heightLabel
@onready var progress_bar = $MarginContainer/VBoxContainer/ProgressBar

var countdown_time: int = 150
var record_height:int = 0

func _ready():
	SignalManager.on_flower_hit.connect(on_flower_hit)

func _on_timer_timeout():
	
	if countdown_time == 0:
		SignalManager.on_timer_zero.emit()
		timer.stop()
	else:
		countdown_time -= 1
	var string_time = str(countdown_time)
	string_time = string_time.insert(string_time.length() - 1, ".")
	if len(string_time) < 3:
		string_time = string_time.insert(0, "0")
	time_label.text = string_time
	if  record_height < round((GameManager.player_position.y*-1 + 370)/100):
		record_height = round((GameManager.player_position.y*-1 +370)/100) 
	height_label.text = str(record_height) + " cm"
	countdown_time = clamp(countdown_time,0, 150)
	progress_bar.value = countdown_time/1.5

func on_flower_hit():
	countdown_time += GameManager.calculate_flower_boost()
