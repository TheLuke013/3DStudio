extends SpringArm

export var mouse_sensitivity := 0.08

var can_move = false
var zoom_sensitivity = 0.1
var zoom_speed = 3.0

var speed = 5.0

func _ready():
	set_as_toplevel(true)

func _process(delta):
	var direction = Vector3.ZERO
	
	if can_move:
		if Input.is_action_pressed("forward"):
			direction.z -= 1
		if Input.is_action_pressed("backward"):
			direction.z += 1
		if Input.is_action_pressed("left"):
			direction.x += 1
		if Input.is_action_pressed("right"):
			direction.x -= 1
	

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		translate(Vector3(-direction.x, 0, direction.z) * speed * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			can_move = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			can_move = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		if event.button_index == BUTTON_WHEEL_UP and event.pressed:
			zoom_camera(-zoom_speed)
		elif event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
			zoom_camera(zoom_speed)

func _unhandled_input(event):
	if event is InputEventMouseMotion and can_move:
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)

func zoom_camera(amount):
	translate(Vector3(0, 0, amount * zoom_sensitivity))
