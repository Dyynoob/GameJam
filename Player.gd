extends CharacterBody3D


@export var default_speed = 5.0
@export var jump_velocity = 4.5
@export var sensitivity = 0.008
var speed = 5.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity = 9.8

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var playerModel = $Head/Player
@onready var Gun = $Head/Camera3D/GUN_Elb
@onready var health_manager = $HealthManager
@onready var gun_barrel = $Head/Camera3D/GUN_Elb/RayCast3D

var bullet = load("res://Bullet.tscn")
var instance

@export var bob_freq = 1.5
@export var bob_amp = 0.08
var t_bob = 0.0

@export var FOV = 75

var sprint_speed = default_speed * 1.5

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func take_damage(damage_amount: int):
	health_manager.health -= damage_amount



func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(40))
		playerModel.rotate_y(camera.rotation_degrees.y)
		Gun.rotate_z(camera.rotation_degrees.z)
		Gun.rotate_y(camera.rotation_degrees.y)
		Gun.rotate_y(camera.rotation.y)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "for", "back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
	if Input.is_action_pressed("sprint") and Input.is_action_pressed("for"):
		speed = sprint_speed
	else:
		speed = default_speed
		
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	var velocity_clamped = clamp(velocity.length(), 0.5, sprint_speed * 2)
	var target_fov = FOV + 1.25 * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	if Input.is_action_just_pressed("shoot"):
		instance = bullet.instantiate()
		print(instance)
		instance.position = gun_barrel.global_position
		instance.transform.basis = gun_barrel.global_transform.basis
		get_parent().add_child(instance)
	
	move_and_slide()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	pos.x = cos(time * bob_freq / 2) * bob_amp
	return pos

