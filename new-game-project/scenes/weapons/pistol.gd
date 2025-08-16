extends Node2D
var labubu_scene : PackedScene = preload("res://scenes/weapons/labubu.tscn")
var can_shoot : bool = true
var damage : int = 5
var magCap : int = 10

signal bullet(pos, direction)
func shoot():
	can_shoot = false
	var laser_markers = $LaserStarts.get_children()
	var selected_laser = laser_markers[randi() % laser_markers.size()]
	$Timer.start()
	var dir = (get_global_mouse_position() - global_position).normalized()
	create_shot(selected_laser.global_position, dir)

func create_shot(pos, direction):
	var labubu = labubu_scene.instantiate() as Area2D
	labubu.position = pos
	labubu.damage = damage
	labubu.rotation_degrees = rad_to_deg(direction.angle()) + 90
	labubu.direction = direction
	get_tree().current_scene.get_node("Projectiles").add_child(labubu)
	

func _on_timer_timeout() -> void:
	can_shoot = true
