extends Node2D

# Node Handles
var grid
var board_cam
var tiles_on_board

# Tile Specific Handles
var letter_tile_node = preload("res://scenes/letter_tile.tscn")
var player_tiles  # Tiles available for the player
var selected_tile

var letter_a_texture_sample = preload("res://assets/Tiles/Letter-A.png")

var tile_info_dict = {
	"?" : {
		"points" : 2,
		"texture" : preload("res://assets/Tiles/FreeTile.png")
	},
	"A" : {
		"points" : 2,
		"texture" : preload("res://assets/Tiles/Letter-A.png")
	},
	"B" : {
		"points" : 4,
		"texture" : preload("res://assets/Tiles/Letter-B.png")
	},
	"C" : {
		"points" : 4,
		"texture" : preload("res://assets/Tiles/Letter-C.png")
	},
	"D" : {
		"points" : 3,
		"texture" : preload("res://assets/Tiles/Letter-D.png")
	},
	"E" : {
		"points" : 2,
		"texture" : preload("res://assets/Tiles/Letter-E.png")
	},
	"F" : {
		"points" : 5,
		"texture" : preload("res://assets/Tiles/Letter-F.png")
	},
	"G" : {
		"points" : 3,
		"texture" : preload("res://assets/Tiles/Letter-G.png")
	},
	"H" : {
		"points" : 5,
		"texture" : preload("res://assets/Tiles/Letter-H.png")
	},
	"I" : {
		"points" : 2,
		"texture" : preload("res://assets/Tiles/Letter-I.png")
	},
	"J" : {
		"points" : 9,
		"texture" : preload("res://assets/Tiles/Letter-J.png")
	},
	"K" : {
		"points" : 6,
		"texture" : preload("res://assets/Tiles/Letter-K.png")
	},
	"L" : {
		"points" : 3,
		"texture" : preload("res://assets/Tiles/Letter-L.png")
	},
	"M" : {
		"points" : 4,
		"texture" : preload("res://assets/Tiles/Letter-M.png")
	},
	"N" : {
		"points" : 3,
		"texture" : preload("res://assets/Tiles/Letter-N.png")
	},
	"O": {
		"points": 2,
		"texture": preload("res://assets/Tiles/Letter-O.png")
	},
	"P": {
		"points": 4,
		"texture": preload("res://assets/Tiles/Letter-P.png")
	},
	"Q": {
		"points": 12,
		"texture": preload("res://assets/Tiles/Letter-Q.png")
	},
	"R": {
		"points": 3,
		"texture": preload("res://assets/Tiles/Letter-R.png")
	},
	"S": {
		"points": 2,
		"texture": preload("res://assets/Tiles/Letter-S.png")
	},
	"T": {
		"points": 3,
		"texture": preload("res://assets/Tiles/Letter-T.png")
	},
	"U": {
		"points": 2,
		"texture": preload("res://assets/Tiles/Letter-U.png")
	},
	"V": {
		"points": 5,
		"texture": preload("res://assets/Tiles/Letter-V.png")
	},
	"W": {
		"points": 5,
		"texture": preload("res://assets/Tiles/Letter-W.png")
	},
	"X": {
		"points": 10,
		"texture": preload("res://assets/Tiles/Letter-X.png")
	},
	"Y": {
		"points": 5,
		"texture": preload("res://assets/Tiles/Letter-Y.png")
	},
	"Z": {
		"points": 12,
		"texture": preload("res://assets/Tiles/Letter-Z.png")
	}
}


# Called when the node enters the scene tree for the first time.
func _ready():
	grid = get_node("Grid")
	board_cam = get_node("BoardCam")
	tiles_on_board = $TilesOnBoard

	# player_tiles = [tile_dict_info_template]
	# selected_tile = letter_tile_node.instantiate()
	# print(letter_a_texture_sample)
	# selected_tile.get_node("Sprite2D").texture = letter_a_texture_sample
	# selected_tile.position = grid.map_to_local(Vector2(0, 3)) - Vector2(grid.tile_set.tile_size) / 2
	# tiles_on_board.add_child(selected_tile)
	# print(tiles_on_board.get_children())
	
	# var letter = 'A'
	# print(tile_info_dict[letter]["points"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the global mouse position
	var global_mouse_pos = get_global_mouse_position()

	# Convert the global mouse position to the tilemap's local coordinates
	var local_mouse_pos = grid.local_to_map(global_mouse_pos)

	# Snap the letter tile to the nearest grid cell
	if (selected_tile): 
		selected_tile.position = grid.map_to_local(local_mouse_pos) - Vector2(grid.tile_set.tile_size) / 2

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			## place it in the tiles on board
			var mouse_map_pos = grid.local_to_map(get_global_mouse_position())
			tiles_on_board.place_tile(selected_tile, mouse_map_pos)
	pass

## Signal from the UI
func _on_hud_letter_selected(letter):
	## Instantiate a tile using the letter
	selected_tile = letter_tile_node.instantiate()
	var tile_info = tile_info_dict[letter]
	selected_tile.get_node("Sprite2D").texture = tile_info.texture
	
	# temporarily place selected_tile in scene
	tiles_on_board.add_child(selected_tile)
	## Find 
	pass # Replace with function body.
