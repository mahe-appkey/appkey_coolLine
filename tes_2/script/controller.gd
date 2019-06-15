extends GridContainer

# signal

# variable
var tile_arr = Array()
var disk_arr = Array()
var hold_disk = null
var original_disk_position
var can_grab
var grabbed_offset = Vector2()
var clicked_tile
var ran_tile
var ran_disk
var pos_x_margin = 150
var empt_tile_index
var temp_tile_index
var num_column = 4
var num_slot = (num_column*num_column)
const tile_class = preload("res://tes_2/script/tile_class.gd")
const disk_class = preload("res://tes_2/script/disk_class.gd")
const disk_texture = [
preload("res://tes_2/img/disk_01.png"),
preload("res://tes_2/img/disk_02.png"),
preload("res://tes_2/img/disk_03.png")]
const diskDictionary = {
	0: {
		"diskName":"disk01",
		"diskType":"trigger_01",
		"diskIcon":disk_texture[0]
	},
	1: {
		"diskName":"disk02",
		"diskType":"trigger_02",
		"diskIcon":disk_texture[1]
	},
	2: {
		"diskName":"disk03",
		"diskType":"trigger_03",
		"diskIcon":disk_texture[2]
	}
}
var cur_chain_tile
var cur_chain_dir
var cur_chain_disk_val
var chain_limit = 11
var cur_chain_index
var cur_chain_disk
var board_border={
	"no_up":{},
	"no_down":{},
	"no_left":{},
	"no_right":{}
}
const block_time = 2
var cur_block_time
var prev_chain_disk_value
var is_rotating :bool = false

func init_chaining(start_tile):
#	initialize needed information for chaining
	var start_index
	for i in range(tile_arr.size()):
		if start_tile == tile_arr[i]:
			start_index=i
	cur_chain_index = start_index
	cur_chain_tile = tile_arr[cur_chain_index]
	cur_chain_disk = cur_chain_tile.disk
	cur_chain_disk_val = cur_chain_disk.trigger_val
	cur_chain_dir = cur_chain_disk.trigger_dir
	prev_chain_disk_value=cur_chain_disk_val
	start_chaining()
	pass
	
func define_border():
#	border definition
	for i in range(num_column):
		board_border["no_up"][i]=i
	for i in range(num_column):
		board_border["no_down"][i]=(num_slot-(i+1))
	for i in range(num_column):
		board_border["no_left"][i]=i*num_column
	for i in range(num_column):
		board_border["no_right"][i]=board_border["no_left"][i]+(num_column-1)
	pass
	
func is_ok_next_dir():
	if (cur_chain_dir == "up" and cur_chain_index in board_border["no_up"])\
	or (cur_chain_dir == "down" and cur_chain_index in board_border["no_down"])\
	or (cur_chain_dir == "left" and cur_chain_index in board_border["no_left"])\
	or (cur_chain_dir == "right" and cur_chain_index in board_border["no_right"]):
		print("check false")
		return false
	else:
		print("check true")
		return true
	pass
	
func check_next():
	if is_ok_next_dir():
		update_cur_index()
	else:
		change_dir(cur_chain_dir)
		print("change dir")
		pass
	pass

func change_dir(dir):
	if dir=="up":
		dir = "left"
	elif dir=="down":
		dir = "right"
	elif dir=="left":
		dir = "down"
	elif dir=="right":
		dir = "up"
	pass
		
func update_cur_index():
	if is_ok_next_dir():
	 	if cur_chain_dir=="up":
	 		cur_chain_index -=num_column
	 	elif cur_chain_dir== "right":
	 		cur_chain_index +=1
	 	elif cur_chain_dir== "left":
	 		cur_chain_index -=1
	 	elif cur_chain_dir== "down":
	 		cur_chain_index+=num_column
	pass

func update_cur_tile():
	if is_ok_next_dir():
		cur_chain_tile = tile_arr[cur_chain_index]
		cur_chain_disk = cur_chain_tile.disk
		for i in range(cur_chain_disk.disk_dir_arr.size()):
			if cur_chain_disk.disk_dir_arr[i] == cur_chain_dir:
				cur_chain_disk_val = cur_chain_disk.disk_value[i]
	pass
	
func chain_me():
#	cur_chain_disk.rotate(prev_chain_disk_value)
	cur_chain_tile.clear_tile()
#	prev_chain_disk_value=cur_chain_disk_val
	print("chain me")
	
func start_chaining():
	var cur_chain_limit =chain_limit
	
	for i in range(chain_limit):
		check_next()
		update_cur_tile()
		chain_me()
#		var prev_chain_index = cur_chain_index
##		update_cur_index()
#		if(prev_chain_index != cur_chain_index) and cur_chain_limit > 0:
#
##			OS.delay_msec(500*prev_chain_disk_value)
#			pass
#		else:
#			break
#	pass
	
func _init():
	self.margin_top= (OS.get_window_size().y/2.5)
	self.margin_left= 10
	self.margin_right= 10
	self.set_columns(num_column)
	
	
func _ready():
	self.set_size(Vector2(get_parent().rect_size.x-pos_x_margin,10))
	self.rect_position.x = pos_x_margin/2
	ran_tile = random_arr(num_slot)
	empt_tile_index = ran_tile
	generate_disk()
	generate_tile()
	add_disk_to_tile(ran_tile)
	define_border()
#	print("Empty Tile no. ",ran_tile)
	pass
		
func add_disk_to_tile(ran_num):
	for i in range (num_slot):
		if (i != ran_num):
			tile_arr[i].setDisk(disk_arr[i])
	pass
	
func generate_disk():
	for i in range(num_slot):
		ran_disk=random_arr(diskDictionary.size())
		var diskName = diskDictionary[ran_disk].diskName
		var diskType = diskDictionary[ran_disk].diskType
		var diskIcon = diskDictionary[ran_disk].diskIcon
		disk_arr.append(disk_class.new(diskName,diskIcon,null,diskType))
	
func generate_tile():
#	init tile
	for i in range(num_slot):
		var tile_slot = tile_class.new(i)
		tile_arr.append(tile_slot)
		self.add_child(tile_slot)
#	print ("tile Size: ",tile_arr.size())
	
func random_arr(i):
	randomize()
	return(randi()%i)
	
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
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
					can_grab = event.pressed
					grabbed_offset=clicked_tile.get_child(0).get_global_position()-get_global_mouse_position()
				
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		for i in range(num_slot):
			tile_arr[i].reset_tile()

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab:
		if clicked_tile != null:
			hold_disk = clicked_tile.disk
			hold_disk.z_index = 99
			hold_disk.global_position = grabbed_offset+get_global_mouse_position()
	elif hold_disk!=null and clicked_tile != null:
		var empt_tile_mousePos = tile_arr[empt_tile_index].get_local_mouse_position()
		var epmt_tile_texture = tile_arr[empt_tile_index].get_texture()
		var inEmptyTile = (empt_tile_mousePos.x >=0 && empt_tile_mousePos.x <= epmt_tile_texture.get_width() && \
				empt_tile_mousePos.y >= 0 && empt_tile_mousePos.y <= epmt_tile_texture.get_height())
		if inEmptyTile:
#			print(clicked_tile.disk.trigger_dir)
			clicked_tile.removeDisk()
			tile_arr[empt_tile_index].setDisk(hold_disk)
			init_chaining(hold_disk.get_parent())
			empt_tile_index = temp_tile_index
			temp_tile_index=0
			
		else: 
			hold_disk.global_position = original_disk_position
		hold_disk.z_index = 1
		hold_disk = null
		clicked_tile = null
		