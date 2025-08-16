extends StaticBody2D


var playerInside : bool = false
@export var doorPrice : int = 500
@export var buyLabelPath : NodePath = "../../Player/Camera2D/UI/BuyDoorLabel"

var buyLabel : Label
func _ready():
	buyLabel = get_node(buyLabelPath)
	buyLabel.position = Vector2(1000, 1000)
	buyLabel.visible = false
	
func _process(_delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		if Globals.money >= doorPrice:
			Globals.money -= doorPrice
			print("BOUGHT DOOR FOR %d", %doorPrice)
			queue_free()
		else:
			print("povo")
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = true
		buyLabel.text = "Press F to buy the door for %d" % doorPrice
		buyLabel.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = false
		buyLabel.visible = false
