extends CharacterBody3D

@export var speed: float = 8.0
@export var bounce_speed: float = 4.0
@export var bounce_time: float = 1.0
@export var attack_delay: float = 0.0
@export var retreat_distance: float = 2.0
@export var damage: int = 15  # Damage dealt to the player when hit

var target: Node = null
var is_attacking: bool = false
var is_bouncing: bool = false
var bounce_timer: float = 0.0
var attack_timer: float = 0.0
var initial_position: Vector3

func _ready():
	initial_position = global_transform.origin

func _physics_process(delta: float):
	if is_attacking:
		attack_player(delta)
	elif is_bouncing:
		bounce_back(delta)
	else:
		attack_timer -= delta
		if attack_timer <= 0:
			find_player()

func find_player():
	# Find the nearest player in the group "player"
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		target = players[0]  # You can implement more complex logic to find the closest player
		is_attacking = true
	else:
		is_attacking = false

func attack_player(delta: float):
	if target and target.is_inside_tree():
		# Move towards the player
		var direction = (target.global_transform.origin - global_transform.origin).normalized()
		velocity = direction * speed
		move_and_slide()

		# Rotate the bird to face the direction of movement
		look_at(target.global_transform.origin)

		# Check if the bird is close to the player (collision detection)
		if global_transform.origin.distance_to(target.global_transform.origin) < 1.0:
			hit_player()

func hit_player():
	# Handle the player getting hit
	if target.has_method("take_damage"):  # Check if the player has a take_damage method
		target.take_damage(damage)  # Subtract player's health by the damage amount
		print("Player Hit! Dealt " + str(damage) + " damage.")

	# Start the bounce-back process
	is_attacking = false
	is_bouncing = true
	bounce_timer = bounce_time

func bounce_back(delta: float):
	bounce_timer -= delta
	if bounce_timer > 0:
		# Move back a short distance along the opposite direction with reduced speed
		var direction = (initial_position - global_transform.origin).normalized()
		velocity = direction * bounce_speed
		move_and_slide()

		# Rotate the bird to face the direction of retreat
		look_at(global_transform.origin + direction)
	else:
		is_bouncing = false
		attack_timer = attack_delay
		target = null
