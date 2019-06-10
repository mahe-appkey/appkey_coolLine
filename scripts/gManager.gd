extends Node

enum {UP, RIGHT, BOTTOM, LEFT}
var numDisk = {UP:1,RIGHT:2,BOTTOM:3,LEFT:4}
var initialRotation = [0.0,90.0,180.0,270.0]
var coordinate_x = 0
var coordinate_y = 0
var rotDisk = 0.0
var randomInitialRotation
var numRed
# direction only for number 1 2 and 3, 0 doesn't have direction


func set_rotDisk(rotate):
	rotDisk = rotate

func rotateDisk (rotate_amount):
	for i in rotate_amount:
		rotDisk -= 90
		updateNum(1)
	
func get_rotDisk():
	return rotDisk
	
func updateNum(num):
	for i in numDisk:
		if (numDisk[i]+num) >= 4:
			numDisk[i] = (numDisk[i] + num)-4


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
