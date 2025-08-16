extends CharacterBody2D

var speed: int = 300
var health : int = 20

func _process(_delta):
	var direction = (Globals.player_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	look_at(Globals.player_pos)

func hit(damage):
	health -= damage
	if health <= 0:
		print("tung died")
		queue_free()
		
	
		
