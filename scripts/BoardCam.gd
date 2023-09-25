extends Camera2D

var timer = 0

var screen_size
var grid

var zoom_speed: float = 0.03
var min_zoom: float = 0.3
var max_zoom: float = 2.0
var drag_sensitivity: float = 0.5

func _ready():
	center_camera()
	grid = get_node("../Grid")

func center_camera():
	screen_size = Vector2(0, 0)
	screen_size.x = get_viewport().get_visible_rect().size.x # Get Width
	screen_size.y = get_viewport().get_visible_rect().size.y # Get Height
	
	var center = screen_size / 2
	
	position = center
	
func _input(event):
	## Get bounds
	var bounds = get_visible_area_bounds()
	var transform_map = grid.local_to_map(get_global_transform().get_origin())
		
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		position -= event.relative * drag_sensitivity / zoom
		increase_grid_cells(bounds, transform_map)
	
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# print(get_global_transform().origin.y)
		# print(get_)
		# print(grid.local_to_map(get_global_mouse_position()))
		pass
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_speed, zoom_speed) * zoom
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_speed, zoom_speed) * zoom
			
		zoom = clamp(zoom, Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
		increase_grid_cells(bounds, transform_map)

func increase_grid_cells(bounds, transform_map):
	var left = grid.local_to_map(Vector2(bounds.left, transform_map.y)).x - 1
	var right = grid.local_to_map(Vector2(bounds.right, transform_map.y)).x + 1
	var top = grid.local_to_map(Vector2(transform_map.x, bounds.top)).y - 1
	var bottom = grid.local_to_map(Vector2(transform_map.x, bounds.bottom)).y + 1
	
	#printt(left, right, top, bottom)
	#print(grid.local_to_map(get_global_mouse_position()))
	# Check top to bottom in the left most and right most if no board tiles
	for i in range(top, bottom + 2): 
		if (!grid.get_cell_tile_data(0, Vector2(left, i))):
			grid.set_cell(0, Vector2(left, i), 0, Vector2i(0,0), 0)
			grid.set_cell(1, Vector2(left, i), 1, Vector2i(0,0), 0)
			
		if (!grid.get_cell_tile_data(0, Vector2(right, i))):
			grid.set_cell(0, Vector2(right, i), 0, Vector2i(0,0), 0)
			grid.set_cell(1, Vector2(right, i), 1, Vector2i(0,0), 0)
			
	# Check left to right in the top most and bottom most if no board tiles
	for i in range(left, right): 
		if (!grid.get_cell_tile_data(0, Vector2(i, top))):
			grid.set_cell(0, Vector2(i, top), 0, Vector2i(0,0), 0)
			grid.set_cell(1, Vector2(i, top), 1, Vector2i(0,0), 0)
			
		if (!grid.get_cell_tile_data(0, Vector2(i, bottom))):
			grid.set_cell(0, Vector2(i, bottom), 0, Vector2i(0,0), 0)
			grid.set_cell(1, Vector2(i, bottom), 1, Vector2i(0,0), 0)
			
	# if (!grid.get_cell_tile_data(0,Vector2(i, transform_map.y))):

func get_visible_area_bounds():
	var rect = Rect2(get_global_position() - Vector2(get_viewport().size) / 2 / zoom, Vector2(get_viewport().size) / zoom)
	# print(rect.position)
	var transform = get_global_transform()
	var min = transform.basis_xform(rect.position)
	var max = transform.basis_xform(rect.position + rect.size)
	return {
		"left": min.x,
		"right": max.x,
		"top": min.y,
		"bottom": max.y
	}

func _process(delta):
	timer += delta
	if timer > 2.0: # Prints every 2 seconds
		timer = 0.0
		print("fps: " + str(Engine.get_frames_per_second()))
	pass
	## Get bounds
	# var bounds = get_visible_area_bounds()
	# var transform_map = grid.local_to_map(get_global_transform().get_origin())
	
	# var top_left = Vector2(bounds.left, bounds.top)
	# var bottom_right = Vector2(bounds.right, bounds.bottom)
	
	# var left = grid.local_to_map(top_left).x
	# var top = grid.local_to_map(top_left).y
	# var right = grid.local_to_map(bottom_right).x
	# var bottom = grid.local_to_map(bottom_right).y
	
	
	## Check if there's a background tile in (left, origin.y), (right, origin.y), (origin.x, top), (origin.x, bottom)
	#for i in range (left, transform_map.y):
	#	if (!grid.get_cell_tile_data(0,Vector2(i, transform_map.y))):
	#		for j in range(top, bottom + 1):
	#			grid.set_cell(0, Vector2(left, j), 0, Vector2i(0,0), 0)
	#			
	
		# from top to bottom of left, set cell
		# for i in range(grid.local_to_map(Vector2(0, top).y), grid.local_to_map(Vector2(0, top).y)): 
		#	grid.set_cell(0, grid.local_to_map(left, i))
	
	
	
	
	
	
	# if (!grid.get_cell_tile_data(0, grid.local_to_map(Vector2(left, top)))):
	#	grid.set_cell(0, Vector2(left,top), 0, Vector2i(0, 0), 0)
	#print(position)	
