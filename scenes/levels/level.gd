extends Node2D
@onready var ammo_label = get_node("Player/Camera2D/UI/Ammo")
@export var card_scene : PackedScene = preload("res://scenes/weapons/card_1.tscn")
@onready var roundLabel = get_node("Player/Camera2D/UI/Round")
@onready var moneyLabel = get_node("Player/Camera2D/UI/Money")
var maxSpawnSize : int = 20
var canSpawnEnemy : bool = true
var onBreak : bool = false
@export var tungScene : PackedScene = preload("res://scenes/entities/tung_enemy.tscn")

func _ready():
	Globals.startTime = Time.get_ticks_msec()
	
	
	

func _process(_delta):
	#Displaying health
	
	$Player/Camera2D/UI/ProgressBar.max_value = Globals.maxHealth
	$Player/Camera2D/UI/ProgressBar.value = Globals.health
	if Globals.health <= 25:
		$PointLight2D.color = Color("#00cbb0cd")
		$Player/Camera2D/UI/ProgressBar.modulate = Color.RED
	else:
		$PointLight2D.color = Color("#00000049")

		$Player/Camera2D/UI/ProgressBar.modulate = Color.GREEN
		
	#Displaying ammo
	ammo_label.text = str(Globals.ammo_amount) + "/" + str(Globals.total_amount)
	ammo_label.add_theme_font_size_override("font_size", 60)
	if Globals.ammo_amount <= 3:
		$Player/Camera2D/UI/Reload.visible = true
		ammo_label.add_theme_color_override("font_color", Color.RED)
	else:
		$Player/Camera2D/UI/Reload.visible = false

		ammo_label.add_theme_color_override("font_color", Color.WHITE)
	roundLabel.text = str(Globals.roundCount)
	moneyLabel.text = str(Globals.money)
	#Game loop
	if not Globals.gameActive:
		get_tree().change_scene_to_file("res://scenes/UI/game_over.tscn")
	else:
		if Globals.enemiesAlive < maxSpawnSize and not onBreak:
			if Globals.enemiesLeft > 0:
				if canSpawnEnemy:
					
					var tungtungInstance = tungScene.instantiate() as CharacterBody2D
					var enemySpawns = $EnemySpawns.get_children()
					var selectedSpawn = enemySpawns[randi() % enemySpawns.size()] 
					tungtungInstance.position = selectedSpawn.global_position
					get_tree().current_scene.get_node("Enemies").add_child(tungtungInstance)
					canSpawnEnemy = false
					Globals.enemiesAlive += 1
					Globals.enemiesLeft -= 1
					$Timers/EnemySpawn.start()
			elif Globals.enemiesLeft == 0 and Globals.enemiesAlive == 0 and not onBreak:
				#Wave done
				$Timers/BreakTimer.start()
				canSpawnEnemy = false
				Globals.enemiesLeft = 6 + Globals.roundCount * 2
				onBreak = true
			
		
		#if cap on zombies not reached, spawn more
		
		#if no more zombies left, go to next round
		
		
		
func _on_card_pickup_blue_got() -> void:
	var card_instance = card_scene.instantiate() as Control
	Globals.gotBlue = true



func _on_enemy_spawn_timeout() -> void:
	canSpawnEnemy = true


func _on_break_timer_timeout() -> void:
	canSpawnEnemy = true
	onBreak = false
	print("NEW ROUND")
	Globals.roundCount += 1


func _on_red_pickup_red_got() -> void:
	Globals.gotRed = true
