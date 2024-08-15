extends Node3D

var health = 100
@onready var hp_bar = $"../Player UI/Health"
@export var low_hp_color:StyleBoxFlat
@onready var fade_rect = $fade
 # Assuming the ColorRect is at the root of the scene

func _ready():
	# Ensure the ColorRect starts fully transparent by setting its modulate property
	fade_rect.modulate = Color(0, 0, 0, 0)

func _process(delta):
	if Input.is_key_pressed(KEY_B):
		health -= 1
	hp_bar.value = health
	if health <= 25:
		hp_bar.add_theme_stylebox_override("fill", low_hp_color)
	if health <= 0:
		await gameOver()

func gameOver():
	# Create a tween node to handle the fade effect
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 2.0) # Fade to black over 2 seconds
	
	# Wait for the fade to complete
	await tween.finished
	
	# Wait for an additional 2 seconds (optional)
	
	# Reload the current scene
	get_tree().reload_current_scene()
