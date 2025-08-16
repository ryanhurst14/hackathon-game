extends Area2D


signal blueGot()



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		blueGot.emit()
		queue_free()
