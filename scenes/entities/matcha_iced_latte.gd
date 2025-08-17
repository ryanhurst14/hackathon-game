extends StaticBody2D


var playerInside : bool = false
@export var doorPrice : int = 0
@export var buyLabelPath : NodePath = "../../Player/Camera2D/UI/BuyDoorLabel"
var buyLabel : Label
@export var andrewScene : PackedScene = preload("res://scenes/entities/final_boss.tscn")


func _ready():
	buyLabel = get_node(buyLabelPath)
	buyLabel.visible = false
	
func _process(_delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		if Globals.gotBlue and Globals.gotRed:
			$AudioStreamPlayer2D.play()
			if not Globals.inFinalBoss:
				var andrewInstance = andrewScene.instantiate() as CharacterBody2D
				andrewInstance.position = Vector2(50,400)
				get_tree().current_scene.add_child(andrewInstance)
			Globals.inFinalBoss = true
			$AudioStreamPlayer2D.finished.connect(queue_free)
		else:
			buyLabel.text = "Need more keycards!"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = true
		buyLabel.text = "You might need some keycards to move this iced matcha latte..."
		buyLabel.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = false
		buyLabel.visible = false
