extends Node
signal total_change
signal ammo_change
signal health_change

var player_pos : Vector2
var player_direction

var total_amount = 40:
	get:
		return total_amount
	set(value):
		total_amount = value
		total_change.emit()
		
var ammo_amount = 100:
	get:
		return ammo_amount
	set(value):
		ammo_amount = value
		ammo_change.emit()
		
	
var player_vulnerable : bool = true
var health = 75:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_vulnerable:
				health = value
				player_vulnerable = false
				#timer
		health_change.emit()
