extends Node3D

var health = 100
@onready var hp_bar = $"../Player UI/Health"
@export var low_hp_color:StyleBoxFlat
func _process(delta):
	if Input.is_key_pressed(KEY_B):
		health -= 1
	hp_bar.value = health
	if health <= 25:
		hp_bar.add_theme_stylebox_override("fill", low_hp_color)
	if health <= 0:
		gameOver()
func gameOver():
	pass
	# TODO: Game over screen and stuff
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()
