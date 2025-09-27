extends CharacterBody2D

@export var gravity: int = 900

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
