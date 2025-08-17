extends CharacterBody2D

var speed: int = 30
var health : int = Globals.enemyHealth
var playerInRange : Node2D = null
var damageInterval = 1
var damageTimer = 1
@onready var player = get_tree().get_root().find_child("Player", true, false)
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D

func _ready() -> void:
	make_path()

func _physics_process(delta: float) -> void:
	var next_position = nav_agent.get_next_path_position()
	var direction = (next_position - global_position).normalized()
	velocity = speed * direction
	move_and_slide()
	look_at(Globals.player_pos)



func make_path() -> void:
	nav_agent.target_position = player.global_position
	
func _process(delta):
	if playerInRange != null:
		damageTimer -= delta
		if damageTimer <= 0:
			playerInRange.hit(25)
			damageTimer = damageInterval

func hit(damage):
	health -= damage
	if health <= 0:
		print("tung died")
		Globals.money += 300
		Globals.enemiesAlive -= 1
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "hit" in body:
		playerInRange = body
		damageTimer = 0
		



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == playerInRange:
		playerInRange = null


func _on_path_timer_timeout() -> void:
	print("making")
	make_path()
