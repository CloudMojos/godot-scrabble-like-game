extends TileMap

var board_width = 9
var board_height = 16

var board_dict = {}

func _ready():
	for x in range(board_width):
		for y in range(board_height):
			set_cell(0, Vector2(x, y), 0, Vector2i(0, 0), 0)
	
func _process(_delta):
	pass

