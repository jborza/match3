extends Node2D

@export var type : TileType

var pressed : bool = false
var original_position

enum TileType {blue,green,purple,red,yellow}
	
func _ready():
	var game = get_node("/root/Game")
	$Sprite.texture = game.get_image(type)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			print("Clicked")
			pressed = true
			original_position = get_global_mouse_position()
		else:
			print("Released")
			global_position = original_position
			pressed = false
	if event is InputEventMouseMotion && pressed:
		print("Motion")
		# todo move only in 4 directions: up,down,left,right
		global_position = get_global_mouse_position()
		# todo can't move in the direction of the wall

