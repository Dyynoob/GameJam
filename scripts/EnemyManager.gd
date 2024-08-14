extends Node3D

@onready var _raycast = $RayCast3D

func _process(delta):
	if _raycast.is_colliding():
		if _raycast.get_collider().name == "CharacterBody3D":
			print("Character Detected")
			$"../CharacterBody3D/HealthManager".health -= 1
