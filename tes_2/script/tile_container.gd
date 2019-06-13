extends GridContainer

var tile_arr = Array()
var disk_arr = Array()
var ran_tile
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
	ran_tile = random_arr(num_slot)
	generate_tile()
	generate_disk()
	add_disk_to_tile(ran_tile)
	print("Empty Tile no. ",ran_tile)
	pass
	
func add_disk_to_tile(ran_num):
	for i in range (num_slot):
		if (i != ran_num):
			tile_arr[i].setDisk(disk_arr[i])
	pass
	
func generate_disk():
	for i in range(num_slot):
		var diskName = diskDictionary[0].diskName
		var diskType = diskDictionary[0].diskType
		var diskIcon = diskDictionary[0].diskIcon
		disk_arr.append(disk_class.new(diskName,diskIcon,null,diskType))
	
func generate_tile():
#	init tile
	for i in range(num_slot):
		var tile_slot = tile_class.new(i)
		tile_arr.append(tile_slot)
		self.add_child(tile_slot)
	print ("tile Size: ",tile_arr.size())
	
func random_arr(i):
	randomize()
	return(randi()%i)
	
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
#		print("mouse_click")
		var clicked_tile
		for tile in tile_arr:
			var tile_mousePos = tile.get_local_mouse_position()
			var tile_texture = tile.get_texture()
			var isClicked = tile_mousePos.x >=0 && tile_mousePos.x <= tile_texture.get_width() && \
			tile_mousePos.y >= 0 && tile_mousePos.y <= tile_texture.get_height()
			if isClicked and (tile!=tile_arr[ran_tile]):
				clicked_tile = tile
				clicked_tile.get_child(0).visible = not clicked_tile.get_child(0).visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
