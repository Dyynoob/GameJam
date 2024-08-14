extends Label

@onready var playerUsername:String
func _ready():
	match OS.get_name():
		"Windows":
			playerUsername = OS.get_environment("USERNAME")
		"Linux":
			playerUsername = OS.get_environment("USER")
	print(playerUsername)
	text = playerUsername + "'s Health"
	DisplayServer.window_set_title(playerUsername + "'s Circuit")
