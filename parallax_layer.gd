extends ParallaxLayer

@export var speed: float = 100.0

func _process(delta: float) -> void:
	# Only move background if a single horizontal key is pressed
	var move_left := Input.is_action_pressed("ui_left")
	var move_right := Input.is_action_pressed("ui_right")

	if move_left and not move_right:
		# Player moves left → background moves right
		motion_offset.x += speed * delta
	elif move_right and not move_left:
		# Player moves right → background moves left
		motion_offset.x -= speed * delta
	# else: no movement if both keys pressed or none
