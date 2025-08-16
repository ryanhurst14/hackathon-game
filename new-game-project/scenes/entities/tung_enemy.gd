extends CharacterBody2D

var speed: int = 30
var health : int = 1
var playerInRange : Node2D = null
var damageInterval = 1
var damageTimer = 1

func _process(delta):
	var direction = (Globals.player_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	look_at(Globals.player_pos)
	
	
	if playerInRange != null:
		damageTimer -= delta
		if damageTimer <= 0:
			playerInRange.hit(20)
			damageTimer = damageInterval

func hit(damage):
	health -= damage
	if health <= 0:
		print("tung died")
		Globals.money += 100
		Globals.enemiesAlive -= 1
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "hit" in body:
		playerInRange = body
		damageTimer = 0
		



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == playerInRange:
		playerInRange = null
