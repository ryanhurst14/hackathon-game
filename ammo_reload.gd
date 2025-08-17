extends Area2D


var playerInside : bool = false
@export var ammoPrice : int = 1000
@export var buyLabelPath : NodePath = "../Player/Camera2D/UI/BuyDoorLabel"
var buyLabel : Label


func _ready():
	buyLabel = get_node(buyLabelPath)
	buyLabel.visible = false
	
func _process(_delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		if Globals.money >= ammoPrice:
			Globals.money -= ammoPrice
			Globals.total_amount += 100
		else:
			buyLabel.text = "Not enough points"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = true
		buyLabel.text = "Read some literature and earn 100 labubu ammos!"
		buyLabel.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = false
		buyLabel.visible = false
