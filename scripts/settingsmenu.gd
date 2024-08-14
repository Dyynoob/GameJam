extends CanvasLayer


func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_vsync_toggled(toggled_on):
	if toggled_on == false:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


func _on_graphical_option_item_selected(index):
	match index:
		0:
			print("Low")
		1:
			print("Medium")
		2:
			print("High")


func _on_window_modes_item_selected(index):
	match index:
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		4:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_music_vol_value_changed(value):
	var musicChannel = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(musicChannel, linear_to_db(value))
	
func _on_sfx_vol_value_changed(value):
	var SFXChannel = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(SFXChannel, linear_to_db(value))
