extends Control

func _ready():
	$VBoxContainer/Message.text = "You beat Andrew Tate and liberated all performatie males! Thank you Gregory the Labubu for your help"
	$VBoxContainer/Round.text = str("You got up to round %d!") % Globals.roundCount
	
func _on_restart_pressed() -> void:
	Globals.gameActive = true
	#way to restart globals?
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
