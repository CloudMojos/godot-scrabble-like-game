extends GridContainer

signal _letter_selected(letter)

var tile_info_dict = {
	"FreeTile" : {
		"points" : 2,
		"texture" : preload("res://assets/Tiles/FreeTile.png")
	},
	"Letter-A" : {
		"points" : 2,
		"texture" : preload("res://assets/Tiles/Letter-A.png")
	},
	"Letter-B" : {
		"points" : 4,
		"texture" : preload("res://assets/Tiles/Letter-B.png")
	},
	"Letter-C" : {
		"points" : 4,
		"texture" : preload("res://assets/Tiles/Letter-C.png")
	},
	"Letter-D" : {
		"points" : 3,
		"texture" : preload("res://assets/Tiles/Letter-D.png")
	},
	"Letter-E" : {
		"points" : 2,
		"texture" : preload("res://assets/Tiles/Letter-E.png")
	},
	"Letter-F" : {
		"points" : 5,
		"texture" : preload("res://assets/Tiles/Letter-F.png")
	},
	"Letter-G" : {
		"points" : 3,
		"texture" : preload("res://assets/Tiles/Letter-G.png")
	},
	"Letter-H" : {
		"points" : 5,
		"texture" : preload("res://assets/Tiles/Letter-H.png")
	},
	"Letter-I" : {
		"points" : 2,
		"texture" : preload("res://assets/Tiles/Letter-I.png")
	},
	"Letter-J" : {
		"points" : 9,
		"texture" : preload("res://assets/Tiles/Letter-J.png")
	},
	"Letter-K" : {
		"points" : 6,
		"texture" : preload("res://assets/Tiles/Letter-K.png")
	},
	"Letter-L" : {
		"points" : 3,
		"texture" : preload("res://assets/Tiles/Letter-L.png")
	},
	"Letter-M" : {
		"points" : 4,
		"texture" : preload("res://assets/Tiles/Letter-M.png")
	},
	"Letter-N" : {
		"points" : 3,
		"texture" : preload("res://assets/Tiles/Letter-N.png")
	},
	"Letter-O": {
		"points": 2,
		"texture": preload("res://assets/Tiles/Letter-O.png")
	},
	"Letter-P": {
		"points": 4,
		"texture": preload("res://assets/Tiles/Letter-P.png")
	},
	"Letter-Q": {
		"points": 12,
		"texture": preload("res://assets/Tiles/Letter-Q.png")
	},
	"Letter-R": {
		"points": 3,
		"texture": preload("res://assets/Tiles/Letter-R.png")
	},
	"Letter-S": {
		"points": 2,
		"texture": preload("res://assets/Tiles/Letter-S.png")
	},
	"Letter-T": {
		"points": 3,
		"texture": preload("res://assets/Tiles/Letter-T.png")
	},
	"Letter-U": {
		"points": 2,
		"texture": preload("res://assets/Tiles/Letter-U.png")
	},
	"Letter-V": {
		"points": 5,
		"texture": preload("res://assets/Tiles/Letter-V.png")
	},
	"Letter-W": {
		"points": 5,
		"texture": preload("res://assets/Tiles/Letter-W.png")
	},
	"Letter-X": {
		"points": 10,
		"texture": preload("res://assets/Tiles/Letter-X.png")
	},
	"Letter-Y": {
		"points": 5,
		"texture": preload("res://assets/Tiles/Letter-Y.png")
	},
	"Letter-Z": {
		"points": 12,
		"texture": preload("res://assets/Tiles/Letter-Z.png")
	}
}

var tiles_in_panel

# Called when the node enters the scene tree for the first time.
func _ready():
	tiles_in_panel = get_children()
	for tile in tiles_in_panel:
		# print(tile.texture.load_path)
		tile.gui_input.connect(_on_tile_gui_input.bind(tile))
		# print(extract_substring(tile.texture.load_path))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_tile_gui_input(event, tile):
	if event is InputEventMouseButton and event.is_pressed():
		#print("Helloo")
		#print(extract_substring(tile.texture.load_path))
		var letter = extract_substring(tile.texture.load_path)
		# !IMPORTANT, ADD MO ITO
		# IF VALID YUNG TILE NA PININDOT TYAKA LANG DAPAT MAG-EMIT
		_letter_selected.emit(letter)
	pass
func extract_substring(full_string):
	var pattern = '/([^/]+).png'
	var regex = RegEx.new()
	regex.compile(pattern)
	var result = regex.search(full_string)
	if result:
		var match = result.get_string(1)
		return match
	else:
		return "No match found"

