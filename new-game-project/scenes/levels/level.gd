extends Node2D
@onready var ammo_label = get_node("Player/Camera2D/UI/Ammo")
@export var card_scene : PackedScene = preload("res://scenes/weapons/card_1.tscn")

func _process(_delta):
	
	#Displaying ammo
	ammo_label.text = str(Globals.ammo_amount) + " / " + str(Globals.total_amount)
	ammo_label.add_theme_font_size_override("font_size", 60)
	if Globals.ammo_amount <= 3:
		ammo_label.add_theme_color_override("font_color", Color.RED)
	else:
		ammo_label.add_theme_color_override("font_color", Color.WHITE)
		
func _on_card_pickup_blue_got() -> void:
	var card_instance = card_scene.instantiate() as Control
	Globals.gotBlue = true
	get_tree().current_scene.get_node("Player/Camera2D/UI/HBoxContainer").add_child(card_instance)
