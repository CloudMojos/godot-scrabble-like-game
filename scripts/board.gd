extends Node2D

# Node Handles
var grid
var board_cam

# Tile Specific Handles
var letter_tile_node = preload("res://scenes/letter_tile.tscn")
var player_tiles  # Tiles available for the player
var selected_tile = {}

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
	grid = get_node("BoardGrid")
	board_cam = get_node("BoardCam")
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
		selected_tile.node.position = grid.map_to_local(local_mouse_pos) - Vector2(grid.tile_set.tile_size) / 2

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and selected_tile:
			# Mouse in tilemap position
			var mouse_map_pos = grid.local_to_map(get_global_mouse_position())
			# Check if there's already a tile in there
			if (grid.get_cell_tile_data(2, mouse_map_pos)):
				var hehe = grid.get_cell_source_id(2, mouse_map_pos)
				# print(hehe)
				# print(letter_from_tile_id(hehe))
				return
			# find the id of the letter
			var id = tile_id_from_letter(selected_tile.letter)
			# place the tile visually in board
			place_tile(id, mouse_map_pos)
			grid.set_cell(2, mouse_map_pos, id, Vector2i(0, 0), 0)
			#
			selected_tile = {}
			return

func tile_id_from_letter(letter):
	for i in range(0, grid.tile_set.get_source_count()):
				if (grid.tile_set.get_source(i).resource_name == selected_tile.letter):
					return i
	return -1

func letter_from_tile_id(tile_id):
	for i in range(0, grid.tile_set.get_source_count()):
				if (i == tile_id):
					return grid.tile_set.get_source(i).resource_name
	return null

func place_tile(tile_id, mouse_map_pos):
	var x = mouse_map_pos.x
	var y = mouse_map_pos.y
	# Check if the letter is a new word (meaning it attaches to no one :<)
	if(is_word_new(mouse_map_pos)):
		# Add it as new word
		grid.words.append(selected_tile.letter)
		# print(grid.words)
	# Modify the words it affects (append, unshift)
	else:
		# "Stringify" the word in four directions
		# Check if it has letters in right or bottom
		# Because we gonna unshift the shit outta it
		# This one is right
		if (grid.get_cell_tile_data(2, Vector2(x + 1, y))):
			if(!is_terminal_tile(Vector2(x - 1, y))):
				var pos = find_terminal_pos(Vector2(x, y), Vector2(-1, 0))
				print("right")
				print(pos)
				
			var old_string = stringify(Vector2(x + 1, y), Vector2(1, 0))
			var index = grid.words.find(old_string)
			grid.words[index] = selected_tile.letter + old_string
		# This one is bottom
		if (grid.get_cell_tile_data(2, Vector2(x, y + 1))):
			if(!is_terminal_tile(Vector2(x, y - 1))):
				var pos = find_terminal_pos(Vector2(x, y), Vector2(0, -1))
				print("bottom")
				print(pos)
				
			var old_string = stringify(Vector2(x, y + 1), Vector2(0, 1))
			var index = grid.words.find(old_string)
			grid.words[index] = selected_tile.letter + old_string
		# If there's a tile in left then do the shit
		if (grid.get_cell_tile_data(2, Vector2(x - 1, y))):
			if(!is_terminal_tile(Vector2(x + 1, y))):
				var pos = find_terminal_pos(Vector2(x, y), Vector2(1, 0))
				print("left")
				print(pos)
			var old_string = stringify(Vector2(x - 1, y), Vector2(-1, 0))
			var index = grid.words.find(old_string)
			grid.words[index] = old_string + selected_tile.letter
		# This one is the top counterpart. Do the shit
		if (grid.get_cell_tile_data(2, Vector2(x, y - 1))):
			if(!is_terminal_tile(Vector2(x, y + 1))):
				var pos = find_terminal_pos(Vector2(x, y), Vector2(0, 1))
				print("top")
				print(pos)
			var old_string = stringify(Vector2(x, y - 1), Vector2(0, -1))
			var index = grid.words.find(old_string)
			grid.words[index] = old_string + selected_tile.letter
		# Find the word in word array
		# Append the letter
	print(grid.words)
	pass
# Recursive method that creates the string in the given direction
# It's recursive so I'm proud of it :>
func stringify(coord, direction):
	var id = grid.get_cell_source_id(2, coord)
	var letter =  letter_from_tile_id(id)
	# Base case
	# If there is no more tile in left or top
	# In other words, if this is the leftmost or topmost
	if (!grid.get_cell_tile_data(2, coord + direction)):
		return letter
	else:
		return stringify(coord + direction, direction) + letter

func is_terminal_tile(pos):
	return !grid.get_cell_tile_data(2, pos)
	
# OwO another recursive function!?
func find_terminal_pos(pos, direction):
	if (!grid.get_cell_tile_data(2, pos + direction)):
		return pos
	else:
		return find_terminal_pos(pos + direction, direction)

func is_word_new(pos):
	var x = pos.x
	var y = pos.y
	if (!grid.get_cell_tile_data(2, Vector2(x, y - 1)) &&
	!grid.get_cell_tile_data(2, Vector2(x - 1, y)) &&
	!grid.get_cell_tile_data(2, Vector2(x + 1, y)) &&
	!grid.get_cell_tile_data(2, Vector2(x, y + 1))):
		return true
	return false
	
## Signal from the UI
func _on_hud_letter_selected(letter):
	## Instantiate a tile using the letter
	selected_tile.node = letter_tile_node.instantiate()
	var tile_info = tile_info_dict[letter]
	selected_tile.node.get_node("Sprite2D").texture = tile_info.texture
	selected_tile.letter = letter


