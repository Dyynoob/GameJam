extends CanvasLayer

@onready var optionsMenu = $"Options Menu"
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible
		optionsMenu.visible = false
		get_tree().paused = !get_tree().paused
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	if optionsMenu.visible == true && Input.is_action_just_pressed("ui_cancel"):
		optionsMenu.visible = false
	# After exiting the pause menu
	if get_tree().paused == false:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
func _on_settings_pressed():
	optionsMenu.visible = true

func _on_resume_pressed():
	get_tree().paused = false
	visible = false
