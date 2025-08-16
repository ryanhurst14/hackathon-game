extends StaticBody2D


var playerInside : bool = false
@export var doorPrice : int = 500
@export var doorIndex : int
@export var buyLabelPath : NodePath = "../../Player/Camera2D/UI/BuyDoorLabel"
var buyLabel : Label


func _ready():
	buyLabel = get_node(buyLabelPath)
	buyLabel.visible = false
	
func _process(_delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		if Globals.money >= doorPrice:
			Globals.money -= doorPrice
			print("BOUGHT DOOR FOR %d", %doorPrice)
			createSpawn(doorIndex)
			queue_free()
		else:
			print("povo")

func createSpawn(doorIndex):
	print('creating spawns')
	var spawnMarker1 : Marker2D = Marker2D.new()
	var spawnMarker2 : Marker2D = Marker2D.new()
	if doorIndex == 1:
		spawnMarker1.position = Vector2(-50, -200)
		spawnMarker2.position = Vector2(-275, -75)
	elif doorIndex == 2:
		spawnMarker1.position = Vector2(175, 225)
		spawnMarker2.position = Vector2(300,175)
	else:
		spawnMarker1.position = Vector2(-200, 150)
		spawnMarker2.position = Vector2(-100, 200)
	get_node("../../EnemySpawns").add_child(spawnMarker1)
	get_node("../../EnemySpawns").add_child(spawnMarker2)


		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = true
		buyLabel.text = "Press F to buy the door for %d" % doorPrice
		buyLabel.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerInside = false
		buyLabel.visible = false
