extends Control




func _ready():
	$VBoxContainer/Message.text = "You beat Andrew Tate and liberated all performatie males! Thank you Gregory the Labubu for your help"
	$VBoxContainer/Round.text = str("You got up to round %d!") % Globals.roundCount
	var timeTaken = (Globals.endTime - Globals.startTime) / 1000
	$VBoxContainer/Time.text = str("You finished with a time of %d seconds!") % timeTaken

func _on_restart_pressed() -> void:
	Globals.gameActive = true
	#way to restart globals?
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
