extends Node

var isGreen = false
var tileIndex
var disk = null
var tileSprite

func _init(tileIndex):
	self.tileIndex = tileIndex
	name = "tileSlot_%d" % tileIndex
	tileSprite = preload("res://scene/tileBackground.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func setDisk(newDisk):
	add_child(newDisk)
	disk = newDisk
	disk.diskSlot = self
	
func pickDisk():
	disk.pickDisk()
	remove_child(disk)
	get_parent().get_parent().add_child(disk)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
