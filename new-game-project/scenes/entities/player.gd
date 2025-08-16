extends CharacterBody2D


@export var max_speed: int = 100
var speed: int = max_speed
var vulnerable : bool = true
var canHeal = false
var reloading = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func ending():
	if Globals.gotBlue:
		print("ENDING")
	else:
		print("gettehblue")

func hit(damage):
	if vulnerable:
		canHeal = false
		vulnerable = false
		Globals.health -= damage
		print(Globals.health)
		$HitTimer.start()
		$HealTimer.start()
		
func _process(_delta: float) -> void:
	#Movement
	if canHeal:
		Globals.health += 0.1
		
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	#rotate
	look_at(get_global_mouse_position())
	Globals.player_direction = (get_global_mouse_position() - position).normalized()
	#Laser shooting input
	if Input.is_action_just_pressed("primary") and $Pistol.can_shoot and Globals.ammo_amount > 0:
		Globals.ammo_amount -= 1
		$Pistol.can_shoot = false
		$Pistol.shoot()

	if Input.is_action_just_pressed("reload") and not reloading and Globals.total_amount > 0:
		reloading = true
		var toReload = min($Pistol.magCap, Globals.total_amount, $Pistol.magCap - Globals.ammo_amount)
		$ReloadTimer.start()
		await $ReloadTimer.timeout
		Globals.ammo_amount += toReload
		Globals.total_amount -= toReload



func _on_hit_timer_timeout() -> void:
	vulnerable = true


func _on_heal_timer_timeout() -> void:
	canHeal = true


func _on_reload_timer_timeout() -> void:
	reloading = false
