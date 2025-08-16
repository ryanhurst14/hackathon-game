extends Node2D

@export var speed: int = 3000
var direction = Vector2.UP
var damage : int

func _ready():
	$Despawn.start()

func _process(delta):
	position += direction * speed * delta
	print(position)

func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit(damage)
	
	queue_free()
	
func _on_despawn_timeout() -> void:
	queue_free()
