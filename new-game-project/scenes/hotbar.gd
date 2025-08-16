extends Control


func _process(_delta):
	if Globals.gotBlue:
		$GridContainer/Button3.visible = true 
	else:
		$GridContainer/Button3.visible = false
			
	if Globals.gotRed:
		$GridContainer/Button.visible = true 
	else:
		$GridContainer/Button.visible = false
