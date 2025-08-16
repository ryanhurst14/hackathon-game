extends Area2D


signal blueGot()



func _on_body_entered(body: Node2D) -> void:
	blueGot.emit()
	queue_free()
