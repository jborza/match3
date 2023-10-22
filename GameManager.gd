extends Node

@export var images : Array[CompressedTexture2D]

enum TileType {blue,green,purple,red,yellow}

func _ready():
	load_sprite_textures()
	
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
