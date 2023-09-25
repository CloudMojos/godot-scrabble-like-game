extends TileMap

var board_width = 9
var board_height = 16

func _ready():
	pass
	
func _process(_delta):
	pass
	
func increase_grid_cells(bounds, transform_map):
	var left = local_to_map(Vector2(bounds.left, transform_map.y)).x
	var right = local_to_map(Vector2(bounds.right, transform_map.y)).x
	var top = local_to_map(Vector2(transform_map.x, bounds.top)).y
	var bottom = local_to_map(Vector2(transform_map.x, bounds.bottom)).y
	
	printt(left, right, top, bottom)
	print(local_to_map(get_global_mouse_position()))
	# Check top to bottom in the left most and right most if no board tiles
	for i in range(top, bottom + 2): 
		if (!get_cell_tile_data(0, Vector2(left, i))):
			set_cell(0, Vector2(left, i), 0, Vector2i(0,0), 0)
			
		if (!get_cell_tile_data(0, Vector2(right, i))):
			set_cell(0, Vector2(right, i), 0, Vector2i(0,0), 0)
			
	# Check left to right in the top most and bottom most if no board tiles
	for i in range(left, right): 
		if (!get_cell_tile_data(0, Vector2(i, top))):
			set_cell(0, Vector2(i, top), 0, Vector2i(0,0), 0)
			
		if (!get_cell_tile_data(0, Vector2(i, bottom))):
			set_cell(0, Vector2(i, bottom), 0, Vector2i(0,0), 0)
			
	# if (!grid.get_cell_tile_data(0,Vector2(i, transform_map.y))):


