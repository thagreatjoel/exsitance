extends CharacterBody2D

@export var gravity: float = 100.0
@export var jump_force: float = -400.0
@export var speed: float = 200.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# Flip sprite left/right
	if direction != 0:
		anim.flip_h = direction < 0

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
		anim.play("jump")  # play jump animation

	# Animations
	elif is_on_floor():
		anim.play("run")  # keep jump animation while in air
	elif direction != 0:
		anim.play("jump")
	else:
		anim.play("idle")

	# Move the body
	move_and_slide()
