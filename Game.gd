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
	for x in range(-100,100,32):
		for y in range(-100,100,32):
			print("Making tile at ",x,",",y)
			create_tile(tile_scene,x,y)
			
func create_tile(tile_scene, x, y):
	var tile = tile_scene.instantiate()
	tile.type = randi() % GameManager.TileType.size()
	tile.position.x = x
	tile.position.y = y
	add_child(tile)		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	timer_tick()
	
