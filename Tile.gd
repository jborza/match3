extends Node2D

@export var type : TileType

enum TileType {blue,green,purple,red,yellow}
	
func _ready():
	var game = get_node("/root/Game")
	$Sprite.texture = game.get_image(type)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		print("Clicked")
	

