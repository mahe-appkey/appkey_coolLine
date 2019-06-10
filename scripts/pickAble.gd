extends KinematicBody2D

# declared variable
var can_grab = false
var is_press_key = false
var grabbed_offset = Vector2()
var turn_speed = deg2rad(1)
var targetAngle = 0.0

# get input
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()
		targetAngle= targetAngle-45.0
		#diskSpr.	

# Called when the node enters the scene tree for the first time.
func _ready():
	print (get_child(0).name)
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var angle = get_rotation_degrees()
	# Define some speed
	var speed = 5.0
    # Calculate direction:
	# the Y coordinate must be inverted,
    # because in 2D the Y axis is pointing down
#	var dir = Vector2(cos(angle), -sin(angle))
	if abs(angle) < abs(targetAngle):
		set_rotation_degrees(angle-speed)
#	if !can_grab and Input.is_key_pressed(KEY_Z):
#    	# Move
#		print(angle)
#		print(targetAngle)
#		if abs(angle) < abs(targetAngle):
#			$disk_sprite.set_rotation(deg2rad(angle))
#			angle -=speed*delta
#		if abs(angle) >= 360:
#			angle = 0
#    	$disk_sprite.set_position($disk_sprite.get_position() + dir * (speed * delta))
#	grab things
#	var dir = $disk_sprite.get_angle_to(get_global_mouse_position())
#	print(get_global_mouse_position())
#	if abs(dir)<turn_speed:
#		$disk_sprite.rotation += dir
#	else:
#		if dir>0:$disk_sprite.rotation += turn_speed
#		if dir<0:$disk_sprite.rotation -= turn_speed
#	var diskSpr = get_child(0)
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab:
		position = get_global_mouse_position() + grabbed_offset
		#diskSpr.set_animation("clear")
#	pass
