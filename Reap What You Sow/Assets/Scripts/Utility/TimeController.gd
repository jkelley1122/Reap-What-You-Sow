extends Node

# Constants
const SECONDS_IN_MINUTE = 60
const MINUTES_IN_DAY = 24
const DAYS_IN_MONTH = 30
const MONTHS_IN_YEAR = 4
const MONTH_NAMES = ["Spring", "Summer", "Autumn", "Winter"]
const START_YEAR = 1982

# Time Variables
var seconds = 55
var minutes = 23
var days = 29
var months = 3
var years = 0

# Timer
var timer = Timer.new()

func _ready():
	self.add_child(timer)
	timer.set_wait_time(1)  # 1 second in real-time
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	seconds += 1
	if seconds >= SECONDS_IN_MINUTE:
		seconds = 0
		minutes += 1
		if minutes >= MINUTES_IN_DAY:
			minutes = 0
			days += 1
			if days >= DAYS_IN_MONTH:
				days = 0
				months += 1
				if months >= MONTHS_IN_YEAR:
					months = 0
					years += 1

	update_display()

func update_display():
	var display_time = "%s:%s, Day %s of %s %s" % [str(minutes).lpad(2, '0'), str(seconds).lpad(2, '0'), str(days + 1), MONTH_NAMES[months], str(START_YEAR + years)]
	print(display_time)
	print("Health: " + str(GameController.player_health))
	print("Stamina: " + str(GameController.player_stamina))
	print("Sanity: " + str(GameController.player_sanity))
