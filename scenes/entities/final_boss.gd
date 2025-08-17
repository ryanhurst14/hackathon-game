extends CharacterBody2D

@export var buyLabelPath : NodePath = "../Player/Camera2D/UI/BuyDoorLabel"
var buyLabel : Label
var canShoot = false
var bugattiScene : PackedScene = preload("res://scenes/weapons/bugatti.tscn")
var damage : int = 50
var health = 500
func _ready():
	buyLabel = get_node(buyLabelPath)
	buyLabel.visible = true
	buyLabel.text = "Gregory... you must defeat, the performative male final boss"
	
func _process(_delta):
	if canShoot:
		canShoot = false
		var bugattiMarkers = get_tree().current_scene.get_node("BugattiMarkers").get_children()
		var selectedBugatti = bugattiMarkers[randi() % bugattiMarkers.size()]
		$Timer.start()
		var dir = (Globals.player_pos - selectedBugatti.global_position).normalized()
		create_shot(selectedBugatti.global_position, dir)
	
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/UI/you_win.tscn")
		
func create_shot(pos, direction):
	var bugatti = bugattiScene.instantiate() as Area2D
	bugatti.position = pos
	bugatti.damage = damage
	bugatti.rotation_degrees = rad_to_deg(direction.angle()) + 90
	bugatti.direction = direction
	get_tree().current_scene.get_node("Projectiles").add_child(bugatti)

func hit(takeaway):
	health -= takeaway
	print(health)

func _on_dialogue_timer_timeout() -> void:
	buyLabel.visible = false


func _on_timer_timeout() -> void:
	canShoot = true
