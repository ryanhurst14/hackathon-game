extends Node2D

@export var speed: int = 3000
var direction = Vector2.UP

func _ready():
	$Despawn.start()

func _process(delta):
	position += direction * speed * delta
	print(position)

func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		print(body)
		body.hit()
	
	queue_free()
	
func _on_despawn_timeout() -> void:
	queue_free()
