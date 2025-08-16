extends Node2D
@onready var ammo_label = get_node("Player/Camera2D/UI/Ammo")
@export var card_scene : PackedScene = preload("res://scenes/weapons/card_1.tscn")
@onready var roundLabel = get_node("Player/Camera2D/UI/Round")
@onready var moneyLabel = get_node("Player/Camera2D/UI/Money")
var maxSpawnSize : int = 20
var canSpawnEnemy : bool = true
var onBreak : bool = false
@export var tungScene : PackedScene = preload("res://scenes/entities/tung_enemy.tscn")
func _process(_delta):
	#Displaying ammo
	ammo_label.text = str(Globals.ammo_amount) + " / " + str(Globals.total_amount)
	ammo_label.add_theme_font_size_override("font_size", 60)
	if Globals.ammo_amount <= 3:
		ammo_label.add_theme_color_override("font_color", Color.RED)
	else:
		ammo_label.add_theme_color_override("font_color", Color.WHITE)
	roundLabel.text = str(Globals.round)
	moneyLabel.text = str(Globals.money)
	#Game loop
	if not Globals.gameActive:
		get_tree().quit()
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
				Globals.enemiesLeft = 6 + Globals.round * 2
				onBreak = true
			
		
		#if cap on zombies not reached, spawn more
		
		#if no more zombies left, go to next round
		
		
		
func _on_card_pickup_blue_got() -> void:
	var card_instance = card_scene.instantiate() as Control
	Globals.gotBlue = true
	get_tree().current_scene.get_node("Player/Camera2D/UI/HBoxContainer").add_child(card_instance)


func _on_enemy_spawn_timeout() -> void:
	canSpawnEnemy = true


func _on_break_timer_timeout() -> void:
	canSpawnEnemy = true
	onBreak = false
	print("NEW ROUND")
	Globals.round += 1
