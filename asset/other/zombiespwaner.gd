extends Node2D

# Hardcoded zombie scene
var zombie_scene = preload("res://Zumbie.tscn")  # Change path if needed
var spawn_interval: float = 3.0
var spawn_timer: float = 0.0

# Hardcoded spawn positions
var spawn_positions = [
	Vector2(200, 400),
	Vector2(600, 400),
	Vector2(1000, 400)
]

func _ready() -> void:
	spawn_timer = spawn_interval

func _process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_zombie()
		spawn_timer = spawn_interval

func spawn_zombie() -> void:
	var zombie = zombie_scene.instantiate()
	# Random spawn position
	zombie.global_position = spawn_positions[randi() % spawn_positions.size()]
	get_parent().add_child(zombie)
