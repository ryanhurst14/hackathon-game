extends Area2D


signal redGot()



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		redGot.emit()
		queue_free()
