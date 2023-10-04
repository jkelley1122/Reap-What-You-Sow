extends ColorRect

const MONTH_NAMES = ["Spring", "Summer", "Autumn", "Winter"]
const START_YEAR = 1982

func _input(event):
	if event.is_action_pressed("debug_menu"):
		if visible:
			hide()
		else:
			show()
		
func update_display(seconds, minutes, days, months, years):
	$Time.text = "%s:%s, Day %s of %s %s" % [str(minutes).lpad(2, '0'), str(seconds).lpad(2, '0'), str(days + 1), MONTH_NAMES[months], str(START_YEAR + years)]
	$Health.text = "Health: " + str(GameController.player_health)
	$Stamina.text = "Stamina: " + str(GameController.player_stamina)
	$Sanity.text = "Sanity: " + str(GameController.player_sanity)
	$Money.text = "Money: " + str(GameController.player_money)
	$DEBUG_FPS.text = "[DEBUG] FPS: " + str(Engine.get_frames_per_second())
