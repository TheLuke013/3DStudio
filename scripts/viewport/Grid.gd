extends Spatial

var grid_size = 1
var grid_extent = 10
var line_color = Color(1, 1, 1, 0.5)

func _ready():
	draw_grid()

func draw_grid():
	var lines = Array()
	
	for i in range(-grid_extent, grid_extent + 1):
		lines.append(Vector3(i * grid_size, 0, -grid_extent * grid_size))
		lines.append(Vector3(i * grid_size, 0, grid_extent * grid_size))

	for i in range(-grid_extent, grid_extent + 1):
		lines.append(Vector3(-grid_extent * grid_size, 0, i * grid_size))
		lines.append(Vector3(grid_extent * grid_size, 0, i * grid_size))

	var line_mesh = ImmediateGeometry.new()
	line_mesh.begin(Mesh.PRIMITIVE_LINES)
	line_mesh.set_color(line_color)
	for line in lines:
		line_mesh.add_vertex(line)
	line_mesh.end()
	
	add_child(line_mesh)
