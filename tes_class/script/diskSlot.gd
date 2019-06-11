extends TextureRect

var slotIndex
var disk = null

func _init(slotIndex):
	self.slotIndex = slotIndex
	name = "diskSlot_%d" % slotIndex
	texture = preload("res://tes_class/img/slot.png")
	mouse_filter =Control.MOUSE_FILTER_PASS
	pass
	
func setDisk(newDisk):
	add_child(newDisk)
	disk = newDisk
	disk.diskSlot = self
	pass
	
func pickDisk():
	disk.pickDisk()
	remove_child(disk)
	get_parent().get_parent().add_child(disk)
	disk = null
	
func putDisk(newDisk):
	disk = newDisk
	disk.diskSlot = self
	disk.putDisk()
	get_parent().get_parent().remove_child(disk)
	add_child(disk)
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
