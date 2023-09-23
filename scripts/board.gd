extends Node2D

# Node Handles
var grid
var board_cam
var tiles_on_board

# Tile Specific Handles
var letter_tile_template = preload("res://scenes/letter_tile.tscn")
var player_tiles  # Tiles available for the player
var selected_tile

var letter_a_texture_sample = preload("res://assets/Tiles/Letter-A.png")

var tile_dict_info_template = {
	"Letter": "A",
	"Points": 2
}

# Called when the node enters the scene tree for the first time.
func _ready():
	grid = get_node("Grid")
	board_cam = get_node("BoardCam")
	tiles_on_board = $TilesOnBoard

	player_tiles = [tile_dict_info_template]
	selected_tile = letter_tile_template.instantiate()
	selected_tile.get_node("Sprite2D").texture = letter_a_texture_sample
	tiles_on_board.add_child(selected_tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the global mouse position
	var global_mouse_pos = get_global_mouse_position()

	# Convert the global mouse position to the tilemap's local coordinates
	var local_mouse_pos = grid.local_to_map(global_mouse_pos)

	# Snap the letter tile to the nearest grid cell
	selected_tile.position = grid.map_to_local(local_mouse_pos) - Vector2(grid.tile_set.tile_size) / 2

func _input(event):
	# if event is InputEventMouseButton:
		# if event.button_index == MOUSE_BUTTON_LEFT:
			# print(grid.local_to_map(get_global_mouse_position()))
			# print(get_global_mouse_position())
	pass
