extends GridContainer

var tile_arr = Array()
var disk_arr = Array()
var hold_disk = null
var original_disk_position
var can_grab
var grabbed_offset = Vector2()
var clicked_tile
var ran_tile
var empt_tile_index
var temp_tile_index
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
	self.margin_top= (OS.get_window_size().y/2.5)
	self.set_columns(num_column)
	self.rect_position.x = 0#(OS.get_window_size().x/5)-(OS.get_window_size().x/5)
#	self.position(Vector2(10,320))
# Called when the node enters the scene tree for the first time.
func _ready():
	ran_tile = random_arr(num_slot)
	empt_tile_index = ran_tile
	generate_disk()
	generate_tile()
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
		for i in range(num_slot):
			var tile = tile_arr[i]
			if (tile!=tile_arr[empt_tile_index]):
				var tile_mousePos = tile.get_local_mouse_position()
				var disk_texture = tile.get_child(0).get_texture()
				var isClicked = tile_mousePos.x >=0 && tile_mousePos.x <= disk_texture.get_width() && \
				tile_mousePos.y >= 0 && tile_mousePos.y <= disk_texture.get_height()
				if isClicked:
					temp_tile_index = i
					clicked_tile = tile
					original_disk_position = tile.disk.global_position
	#				clicked_tile.get_child(0).visible = not clicked_tile.get_child(0).visible
					can_grab = event.pressed
					grabbed_offset=clicked_tile.get_child(0).position - get_global_mouse_position()
					clicked_tile.clear_tile()
				
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		for i in range(num_slot):
			tile_arr[i].reset_tile()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab:
#		clicked_tile.get_child(0).position = get_global_mouse_position() + grabbed_offset
		if clicked_tile != null:
			hold_disk = clicked_tile.disk
			hold_disk.z_index = 99
			hold_disk.global_position = get_global_mouse_position()
	elif hold_disk!=null and clicked_tile != null:
		var empt_tile_mousePos = tile_arr[empt_tile_index].get_local_mouse_position()
		var epmt_tile_texture = tile_arr[empt_tile_index].get_texture()
		var inEmptyTile = (empt_tile_mousePos.x >=0 && empt_tile_mousePos.x <= epmt_tile_texture.get_width() && \
				empt_tile_mousePos.y >= 0 && empt_tile_mousePos.y <= epmt_tile_texture.get_height())
		if inEmptyTile:
			clicked_tile.removeDisk()
			tile_arr[empt_tile_index].setDisk(hold_disk)
			empt_tile_index = temp_tile_index
		else: 
			hold_disk.global_position = original_disk_position
		hold_disk.z_index = 1
		hold_disk = null
		clicked_tile = null
		