extends CharacterBody2D


@export var max_speed: int = 100
var speed: int = max_speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	#rotate
	look_at(get_global_mouse_position())
	Globals.player_direction = (get_global_mouse_position() - position).normalized()
	#Laser shooting input
	if Input.is_action_pressed("primary") and $Pistol.can_shoot and Globals.ammo_amount > 0:
		Globals.ammo_amount -= 1
		Globals.total_amount -= 1
		$Pistol.can_shoot = false
		$Pistol.shoot()		
		
		
		
		
	
