extends Node
signal total_change
signal ammo_change
signal health_change

var player_pos : Vector2
var player_direction
var gotBlue = false
var gotRed = false
var inFinalBoss = false
var gameActive = true 
var maxHealth = 75
var pistolDamage = 25
var enemyHealth = 50
var roundCount = 1:
	get:
		return roundCount
	set (value):
		roundCount = value

var enemiesLeft = 6

var enemiesAlive = 0:
	get:
		return enemiesAlive
	set (value):
		enemiesAlive = value
		
var total_amount = 40:
	get:
		if total_amount <= 0:
			return 0
		
		return total_amount
	set(value):
		total_amount = value
		total_change.emit()
		
var ammo_amount = 10:
	get:
		return ammo_amount
	set(value):
		ammo_amount = value
		ammo_change.emit()

var money = 10000:
	get:
		return money
	set(value):
		money = value
	
var health = maxHealth:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			health = value
		health_change.emit()
		
		if value <= 0:
			Globals.gameActive = false
