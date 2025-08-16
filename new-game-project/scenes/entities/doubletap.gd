extends StaticBody2D

var artists = ["Laufey", "beabadoobee", "Clairo"]
var playerInside : bool = false
@export var doorPrice : int = 2000
@export var buyLabelPath : NodePath = "../Player/Camera2D/UI/BuyDoorLabel"
var buyLabel : Label

func _ready():
	buyLabel = get_node(buyLabelPath)
	buyLabel.visible = false
	
func _process(_delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		if Globals.money >= doorPrice:
			$AudioStreamPlayer2D.play()
			$MusicTimer.start()
			Globals.money -= doorPrice
			Globals.pistolDamage *= 2
			
		else:
			var artist = artists[randi() % artists.size]
			buyLabel.text = "You could not name one %s song!" % artist



func _on_enter_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = true
		buyLabel.text = "Press F to buy. These wireless headphones pack a punch! ($%d)" % doorPrice
		buyLabel.visible = true


func _on_enter_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = false
		buyLabel.visible = false


func _on_music_timer_timeout() -> void:
	$AudioStreamPlayer2D.stop()
