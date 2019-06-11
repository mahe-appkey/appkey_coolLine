extends TextureRect

var diskIcon
var diskType
var diskSlot
var picked = false

func _init(diskName,diskTexture, diskSlot,diskType):
	name = diskName
	self.diskType = diskType
	texture = diskTexture
	self.diskSlot = diskSlot
	mouse_filter = Control.MOUSE_FILTER_PASS
	
func pickDisk():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	picked = true
	pass
	
func putDisk():
	rect_global_position = Vector2(0,0)
	mouse_filter = Control.MOUSE_FILTER_PASS
	picked = false
	pass
	

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
