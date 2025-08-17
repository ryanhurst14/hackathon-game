extends StaticBody2D


var playerInside : bool = false
@export var doorPrice : int = 2500
@export var buyLabelPath : NodePath = "../Player/Camera2D/UI/BuyDoorLabel"
var buyLabel : Label

func _ready():
	buyLabel = get_node(buyLabelPath)
	buyLabel.visible = false
	
func _process(_delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		if Globals.money >= doorPrice:
			$AudioStreamPlayer2D.play()
			Globals.health = 100
			
		else:
			buyLabel.text = "Need more aura!"


func _on_enter_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = true
		buyLabel.text = "Press F to buy. These jeans might give you more protection ($%d)" % doorPrice
		buyLabel.visible = true


func _on_enter_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = false
		buyLabel.visible = false
