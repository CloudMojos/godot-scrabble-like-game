extends TileMap

var tiles_in_board = {}
var words = []

func _ready():
	pass
	
# Word Validation
func find_horizontal_words():
	# find the leftmost and rightmost, use it in range
	var horizontal_words = []
	var horizontal = find_range("horizontal")
	var vertical = 	find_range("vertical")
	
	for col in range(vertical.x, vertical.y + 1):
		var word = ""
		for row in range(horizontal.x, horizontal.y + 1):
			var letter = letter_from_tile_id(get_cell_source_id(2, Vector2i(row, col)))
			if (letter):
				word += letter
			elif len(word) > 1:
				horizontal_words.append(word)
				word = ""
			elif (!letter):
				word = ""
		if len(word) > 1:
			horizontal_words.append(word)
			word = ""
		
	return horizontal_words

func find_vertical_words():
	# find the topmost and bottommost, use it in range
	var vertical_words = []
	var horizontal = find_range("horizontal")
	var vertical = 	find_range("vertical")
	for row in range(horizontal.x, horizontal.y + 1):
		var word = ""
		for col in range(vertical.x, vertical.y + 1):
			var letter = letter_from_tile_id(get_cell_source_id(2, Vector2i(row, col)))
			if (letter):
				word += letter
			elif len(word) > 1:
				vertical_words.append(word)
				word = ""
			elif (!letter):
				word = ""
		if len(word) > 1:
			vertical_words.append(word)
			word = ""
	return vertical_words

# Utils
func find_range(direction):
	var dir
	if direction == "horizontal":
		dir = 0
	elif direction == "vertical":
		dir = 1 
		
	var arr = []
	
	for i in tiles_in_board.keys():
		arr.append(i[dir])
	
	var min = arr[0]
	var max = arr[0]
	
	for i in arr:
		if i < min:
			min = i
		if i > max:
			max = i
	return Vector2(min, max)

func tile_id_from_letter(letter):
	for i in range(0, tile_set.get_source_count()):
				if (tile_set.get_source(i).resource_name == letter):
					return i
	return -1

func letter_from_tile_id(tile_id):
	for i in range(0, tile_set.get_source_count()):
				if (i == tile_id):
					return tile_set.get_source(i).resource_name
	return null

## Drag and drop
# Feeling ko dito dapat yung drag and drop instead na sa parent node.
# Check muna kung may letter tile dun sa map coord
# Then let dragging true if input event is mouse click
# Tas let dragging false if input event is mouse drop
# If dragging true, check yung local_to_map position tas ilipat dun yung tile.
# If invalid, ibalik sa dati.

# Yung approach na nakikita ko, dapat ihihide lang yung tile pag dinrag, 
# instead of completely reomving it, tas mawawala lang pag valid yung drag dest

func _unhandled_input(event):
	if event is InputEventMouseButton:
		# Check muna kung may letter tile dun sa map coord
		var mouse_map_pos = local_to_map(get_global_mouse_position())
		if (get_cell_tile_data(2, mouse_map_pos)):
			return
		
		
		return
