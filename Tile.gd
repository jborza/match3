extends Node2D

@export var type : GameManager.TileType

var pressed : bool = false
var original_mouse_position
var original_tile_position

var size_x : int
var size_y : int
	
func _ready():
	$Sprite.texture = GameManager.get_image(type)
	size_x = $Sprite.texture.get_width()
	size_y = $Sprite.texture.get_height()

func position_to_size(changed_position):
	changed_position.x = min(changed_position.x, size_x)
	changed_position.x = max(changed_position.x, -size_x)
	changed_position.y = min(changed_position.y, size_y)
	changed_position.y = max(changed_position.y, -size_y)
	return changed_position

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			print("Clicked @ ",position)
			pressed = true
			original_mouse_position = get_global_mouse_position()
			original_tile_position = position
		elif pressed:
			print("Released @ ",position," pressed=",pressed)
			global_position = original_tile_position
			pressed = false
	if event is InputEventMouseMotion && pressed:
		# move only in 4 directions: up,down,left,right
		var changed_position = get_global_mouse_position() - original_mouse_position
		changed_position = position_to_size(changed_position)
		if(abs(changed_position.x) > abs(changed_position.y)):
			#move by x
			global_position.x = original_tile_position.x + changed_position.x
			global_position.y = original_tile_position.y
		else: #move by y
			global_position.x = original_tile_position.x
			global_position.y = original_tile_position.y + changed_position.y
		# todo can't move in the direction of the wall
		# todo move the neighboring tile
		var neighbor = GameManager.get_tile_by_location(get_global_mouse_position())
		print("Neighbor:", neighbor.position)
