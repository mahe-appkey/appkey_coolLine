extends GridContainer

var tile_arr = Array()
var disk_arr = Array()
var num_column = 4
var num_slot = (num_column*num_column)
const tile_class = preload("res://tes_2/script/tile_class.gd")
const disk_class = preload("res://tes_2/script/disk_class.gd")
const disk_texture = [preload("res://tes_2/img/backtile_select2.png")]
const diskDictionary = {
	0: {
		"diskName":"disk01",
		"diskType":"UP",
		"diskIcon":disk_texture[0]
	},
	1: {
		"diskName":"disk02",
		"diskType":"UP",
		"diskIcon":disk_texture[0]
	},
	2: {
		"diskName":"disk03",
		"diskType":"UP",
		"diskIcon":disk_texture[0]
	},
	3: {
		"diskName":"disk04",
		"diskType":"UP",
		"diskIcon":disk_texture[0]
	},
}

func _init():
	self.set_columns(num_column)
#	self.position(Vector2(10,320))
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(num_slot):
#		init tile
		var tile_slot = tile_class.new(i)
		tile_arr.append(tile_slot)
		self.add_child(tile_slot)
	print ("tile Size: ",tile_arr.size())
	
	for i in range(num_slot):
		var diskName = diskDictionary[0].diskName
		var diskType = diskDictionary[0].diskType
		var diskIcon = diskDictionary[0].diskIcon
		disk_arr.append(disk_class.new(diskName,diskIcon,null,diskType))
		tile_arr[i].setDisk(disk_arr[i])
	
	
	pass
	
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		print("mouse_click")
		disk_arr[0].rotate_disk()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
