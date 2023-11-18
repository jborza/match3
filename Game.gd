extends Node2D

var score : int = 0
var time_seconds : int = 0

@export var score_label : Label
@export var time_label : Label

func add_score(addition):
	score += addition

func seconds_to_mmss(seconds):
	var result : String = "%02d:%02d" % [seconds / 60, seconds % 60]
	return result

func timer_tick():
	time_seconds += 1
	time_label.text = seconds_to_mmss(time_seconds)

# Called when the node enters the scene tree for the first time.
func _ready():
	# generate tiles
	# https://docs.godotengine.org/en/stable/tutorials/scripting/nodes_and_scene_instances.html
	var tile_scene = load("res://Tile.tscn")
	var position_x = 0
	var position_y = 0
	for x in range(-100,100,32):
		for y in range(-100,100,32):
			create_tile(tile_scene,x,y, position_x, position_y)
			position_y += 1
		position_x += 1

	shuffle_set()
	
func board_is_ready_x():
	var width = 7
	var height = 7
	#is there any 3-match?
	
	#go left to right
	#another line until done
	for y in range(height - 2):
		for x in range(width - 2):
			print(x, ",", y,":", GameManager.get_tile_color(x,y))
			#if 3 are the same, return false
			if(GameManager.get_tile_color(x,y) 
			== GameManager.get_tile_color(x+1,y) 
			== GameManager.get_tile_color(x+2,y)):
				return Vector2(x,y)
	
	#TODO go top down
	#another line
	return null
	
func board_is_ready_y():
	return null
	
func shuffle_tile():
	pass
			
func shuffle_set():
	# repeat until the board is shuffled
	while(board_is_ready_x() != null):
		shuffle_tile()
	while(board_is_ready_y() != null):
		shuffle_tile()
	pass
			
func create_tile(tile_scene, x, y, position_x, position_y):
	var tile = tile_scene.instantiate()
	tile.type = randi() % GameManager.TileType.size()
	tile.position.x = x
	tile.position.y = y
	tile.position_x = position_x
	tile.position_y = position_y
	add_child(tile)
	GameManager.add_tile(tile)	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	timer_tick()
	
