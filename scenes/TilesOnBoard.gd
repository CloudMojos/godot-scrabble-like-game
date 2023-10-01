extends Node2D

var tiles_array = []

var letter_tile_node = preload("res://scenes/letter_tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# When a tile is placed, store it in an array.
	
	pass
	
func place_tile(tile_node, coord):
	# How do I store the coord to the tile_node?
	# coord is vector2
	var key = str(coord.x) + "," + str(coord.y)
	var new_tile = {key: tile_node}
	tiles_array.append(new_tile)
	print(tiles_array)
	pass
func create_tile_node():
	# create an instance of letter_tile and append it in tiles_array
	pass
