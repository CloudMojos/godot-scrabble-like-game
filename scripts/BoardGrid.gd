extends TileMap

var words = []

func _ready():
	set_cell(2, Vector2(0, 0), 3, Vector2i(0,0), 0)
	
	print(tile_set.get_source(3).resource_name)
	
