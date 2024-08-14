extends CanvasLayer

@onready var animationPlayer = $AnimationPlayer
func _on_play_pressed():
	animationPlayer.play("out")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://world.tscn")
	
