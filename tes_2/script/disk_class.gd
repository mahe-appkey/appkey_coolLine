extends Sprite

var diskIcon
var diskType
var diskSlot
var picked = false
var divider = 0.5
var angle_rot = 45
var rot_speed = 2

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
	print("method call rotate_disk")
	while irot >= angle_rot:
		print("rotate ",irot)
		self.set_rotation(deg2rad(irot))
		irot +=rot_speed
	
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
