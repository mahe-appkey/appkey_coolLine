extends KinematicBody2D

# declared variable
var can_grab = false
var grabbed_offset = Vector2()
var turn_speed = deg2rad(1)

# get input
func _input_event(viewport, event, shape_idx):
	var tileSpr = get_child(1)
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()
		tileSpr.set_animation("default")

# Called when the node enters the scene tree for the first time.
func _ready():
	print (get_child(1).name)
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = $tileSprite.get_angle_to(get_global_mouse_position())
	if abs(dir)<turn_speed:
		$tileSprite.rotation += dir
	else:
		if dir>0:$tileSprite.rotation += turn_speed
		if dir<0:$tileSprite.rotation -= turn_speed
	var tileSpr = get_child(1)
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab:
		position = get_global_mouse_position() + grabbed_offset
		tileSpr.set_animation("clear")
#	pass
