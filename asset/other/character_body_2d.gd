extends CharacterBody2D

@export var speed: float = 100.0
@export var detect_range: float = 500.0
@export var attack_range: float = 50.0
@export var attack_cooldown: float = 1.0
@export var max_health: int = 3

@onready var anim = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

var health: int
var is_alive: bool = true
var attack_timer: float = 0.0
var last_direction: String = "left"

func _ready() -> void:
	health = max_health
	anim.play("Lidle")
	add_to_group("Zombies")

func _physics_process(delta: float) -> void:
	if not is_alive:
		anim.play("Lidle") if last_direction == "left" else anim.play("Ridle")
		return

	var players = get_tree().get_nodes_in_group("Player")
	if players.size() == 0:
		return
	var player = players[0]
	var distance = global_position.distance_to(player.global_position)

	if distance <= detect_range:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed
		move_and_slide()
		last_direction = "left" if direction.x < 0 else "right"

		anim.play("Lrun") if last_direction == "left" else anim.play("Rrun")

		attack_timer -= delta
		if distance <= attack_range and attack_timer <= 0:
			attack_player(player)  # ✅ just call, no assignment
			attack_timer = attack_cooldown
	else:
		velocity.x = 0
		anim.play("Lidle") if last_direction == "left" else anim.play("Ridle")

func take_damage(amount: int) -> void:
	if not is_alive:
		return
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	is_alive = false
	anim.play("Lidle") if last_direction == "left" else anim.play("Ridle")
	collision_shape.disabled = true
	velocity = Vector2.ZERO

func attack_player(player_node) -> void:
	if player_node.has_method("take_damage"):
		player_node.take_damage(1)
	anim.play("Lattack") if last_direction == "left" else anim.play("Rattack")
