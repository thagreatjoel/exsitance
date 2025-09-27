extends CharacterBody2D

@export var speed = 100
@export var attack_range = 50
@export var attack_cooldown = 1.5
var attack_timer = 0.0

@onready var player = get_node("$../Player") # Change to your player node
@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	if not player:
		return

	var distance = global_position.distance_to(player.global_position)

	if distance > attack_range:
		# Move towards player
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		anim.play("ZL-run")
	else:
		# Attack
		velocity = Vector2.ZERO
		move_and_slide()
		if attack_timer <= 0:
			anim.play("ZL-attack")
			attack_timer = attack_cooldown
			attack_player()
		else:
			anim.play("ZL-idle")

	if attack_timer > 0:
		attack_timer -= delta

func attack_player():
	# Your damage logic here
	print("Attacking player!")
