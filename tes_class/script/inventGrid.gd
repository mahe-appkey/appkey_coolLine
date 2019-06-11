extends GridContainer

# disk class
const diskClass = preload("res://tes_class/script/diskClass.gd")
# disk slot class
const diskSlotClass = preload("res://tes_class/script/diskSlot.gd")

# texture for slot tile
const slotTexture = preload("res://tes_class/img/slot.png")
# disk image
const diskImages = [
	preload("res://assets/circle.png")
]
const diskDictionary = {
	0: {
		"diskName":"disk01",
		"diskType":"UP",
		"diskIcon":diskImages[0]
	},
	1: {
		"diskName":"disk02",
		"diskType":"UP",
		"diskIcon":diskImages[0]
	},
	2: {
		"diskName":"disk03",
		"diskType":"UP",
		"diskIcon":diskImages[0]
	},
	3: {
		"diskName":"disk04",
		"diskType":"UP",
		"diskIcon":diskImages[0]
	},
}
var slotList = Array()
var diskList = Array()

var holdingItem = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(25):
#		generating disk
		var diskName = diskDictionary[0].diskName
		var diskType = diskDictionary[0].diskType
		var diskIcon = diskDictionary[0].diskIcon
		diskList.append(diskClass.new(diskName,diskIcon,null,diskType))
#		generating slot
		var slot = diskSlotClass.new(i)
		slotList.append(slot)
		add_child(slot)
	
	for i in range(4):
		slotList[i].setDisk(diskList[i])
	
	pass # Replace with function body.
	
func _input(event):
	if holdingItem != null && holdingItem.picked:
		holdingItem.rect_global_position = Vector2(event.position.x,event.position.y)
		
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var clickedSlot
		for slot in slotList:
			var slotMousePos = slot.get_local_mouse_position()
			var slotTexture = slot.texture
			var isClicked = slotMousePos.x >=0 && slotMousePos.x <= slotTexture.get_width() && \
			slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height()
			if isClicked:
				clickedSlot = slot
				
		if holdingItem != null:
			if clickedSlot.disk != null:
				var tempDisk = clickedSlot.disk
				var oldSlot = slotList[slotList.find(holdingItem.diskSlot)]
				clickedSlot.pickDisk()
				clickedSlot.putDisk(holdingItem)
				holdingItem = null
				oldSlot.putDisk(tempDisk)
			else:
				clickedSlot.putDisk(holdingItem)
				holdingItem = null
		elif clickedSlot.disk != null:
			holdingItem = clickedSlot.disk
			clickedSlot.pickDisk()
			holdingItem.rect_global_position = Vector2(event.position.x, event.position.y)
#		else:
#			holdingItem = null
		pass
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
