class_name FourthWallBreakManager
extends Node

@export_category("Text file")
@export var Title:String
@export_multiline var Text:String

var placeTolog:String
func _ready():
	match OS.get_name():
		"Windows":
			placeTolog = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
		"Linux":
			placeTolog = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)

func save(content):
	var dir = DirAccess.open(placeTolog)
	dir.make_dir("Your Logs")
	var file = FileAccess.open(placeTolog + "/Your Logs/" + Title, FileAccess.WRITE)
	file.store_string(content)

func _on_area_3d_body_entered(body):
	save(Text)
