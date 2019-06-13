extends Sprite

var diskIcon
var diskType
var diskSlot
var picked = false
var divider = 0.5
var angle_rot = 0
var rot_amount = 45
var rot_speed = 1
var rot_time = 3

func _init(diskName,diskTexture, diskSlot,diskType):
	name = diskName
	self.diskType = diskType
	texture = diskTexture
	self.diskSlot = diskSlot
	
func _ready():
	var disk_scale = get_parent().get_rect().size/(2*180)
	self.scale = disk_scale
	self.set_centered(true)
	self.position.x=get_parent().get_rect().size.x/2
	self.position.y=get_parent().get_rect().size.y/2
	self.set_rotation(deg2rad(0))
	
func rotate_disk():
	var irot = 0.0
	if abs(angle_rot) == 360:
		angle_rot = 0
	angle_rot-= rot_amount
	print("angle rot: ",angle_rot)
	var time_delta = 0
#	print("method call rotate_disk")	while time_delta <= rot_time:
	while irot >= angle_rot:
#		print("_process_delta: ",get_process_delta_time())
		self.set_rotation(deg2rad(irot))
		irot -=rot_speed

	pass

#func _input(event):
#	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
##		print("mouse_click")
#		self.rotate_disk()
	
func pickDisk():
	picked = true
	pass
	
func putDisk():
	picked = false
	pass
	

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
