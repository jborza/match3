extends Node2D

var score : int = 0
var time_seconds : int = 0

@export var score_label : Label
@export var time_label : Label

@export var images : Array[CompressedTexture2D]

enum TileType {blue,green,purple,red,yellow}

var boo : int

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
	load_sprite_textures()
	if(GameManager.loaded):
		return
	# generate tiles
	# https://docs.godotengine.org/en/stable/tutorials/scripting/nodes_and_scene_instances.html
	var tile_scene = load("res://Tile.tscn")
	for x in range(-100,100,32):
		for y in range(-100,100,32):
			print("Making tile at ",x,",",y)
			var tile = tile_scene.instantiate()
			tile.type = randi() % TileType.size()
			tile.position.x = x
			tile.position.y = y
			add_child(tile)
	GameManager.loaded = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	timer_tick()
	
func get_image(name):
	return images[name]

func load_sprite_texture(index):
	var name = TileType.keys()[index]
	var image_path = str("res://Sprites/tile_", name, ".png")
	var imported_resource = load(image_path)
	images.append(imported_resource)
	
func load_sprite_textures():
	load_sprite_texture(TileType.blue)
	load_sprite_texture(TileType.green)
	load_sprite_texture(TileType.purple)
	load_sprite_texture(TileType.red)
	load_sprite_texture(TileType.yellow)
