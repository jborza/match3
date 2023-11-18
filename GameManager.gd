extends Node

@export var images: Array[CompressedTexture2D]
var tiles: Array[CharacterBody2D]

enum TileType { blue, green, purple, red, yellow }


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


func add_tile(tile):
	tiles.append(tile)


func get_tile_by_location(location, tile_to_ignore) -> CharacterBody2D:
	var closest_tile
	var closest_location = INF
	for tile in tiles:
		if tile == tile_to_ignore:
			continue
		var loc = sqrt(pow(tile.position.x - location.x, 2) + pow(tile.position.y - location.y, 2))
		if loc < closest_location:
			closest_location = loc
			closest_tile = tile
	return closest_tile


func get_tile_color(x, y):
	#find tiles by x,y
	for tile in tiles:
		if tile.position_x == x && tile.position_y == y:
			return tile.type
