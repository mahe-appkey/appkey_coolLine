extends GridContainer

# signal
signal tile_greened
signal chain_end
signal disk_spin
# variable
const g_ratio = 1.618
var tile_arr = Array()
var disk_arr = Array()
var hold_disk = null
var original_disk_position
var can_grab
var able_to_drag = true
var grabbed_offset = Vector2()
var clicked_tile
var ran_tile
var ran_disk
var wait_time = 0.2
var pos_x_margin = 30*g_ratio
var empt_tile_index
var temp_tile_index
var num_column = 4
var num_slot = (num_column*num_column)
const tile_class = preload("res://CoolLine_Max11/script/tile_class.gd")
const disk_class = preload("res://CoolLine_Max11/script/disk_class.gd")
const disk_texture = [
preload("res://CoolLine_Max11/img/disk_01.png"),
preload("res://CoolLine_Max11/img/disk_02.png"),
preload("res://CoolLine_Max11/img/disk_03.png")]
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
var prev_chain_count
var cur_chain_count
var cur_chain_index
var cur_chain_disk
var border_no_up = Array()
var border_no_down = Array()
var border_no_left = Array()
var border_no_right = Array()
const block_time = 2
var block_limit
var prev_chain_disk_value
#var is_rotating :bool = false
var prev_chain_index
var dir_changed
var empty_tile_border = [-1,-1,-1,-1]
var next_chain_index
var is_trigger = true

func _init():
#	self.margin_top= (OS.get_window_size().y/(1.5*g_ratio))
	self.margin_left= 10*g_ratio
	self.margin_right= 10*g_ratio
	self.set_columns(num_column)
	
	
func _ready():
	self.set_size(Vector2(get_parent().rect_size.x-pos_x_margin,5*g_ratio))
	self.rect_position.x = pos_x_margin/2
	ran_tile = random_arr(num_slot)
	empt_tile_index = ran_tile
	generate_disk()
	generate_tile()
	add_disk_to_tile(ran_tile)
	define_border()
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
	
func random_arr(i):
	randomize()
	return(randi()%i)

func reset_all_tile():
	for i in range(num_slot):
		tile_arr[i].reset_tile()
	
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and able_to_drag:
		for i in range(num_slot):
			var tile = tile_arr[i]
			if (tile!=tile_arr[empt_tile_index]):
				var tile_mousePos = tile.get_local_mouse_position()
				var disk_texture = tile.get_child(1).get_texture()
				var isClicked = tile_mousePos.x >=0 && tile_mousePos.x <= disk_texture.get_width() && \
				tile_mousePos.y >= 0 && tile_mousePos.y <= disk_texture.get_height()
				if isClicked:
					temp_tile_index = i
					clicked_tile = tile
					original_disk_position = tile.disk.global_position
					can_grab = event.pressed
					grabbed_offset=clicked_tile.get_child(1).get_global_position()-get_global_mouse_position()
				
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		for i in range(num_slot):
			tile_arr[i].clear_tile()
			
#func _input(event):
#	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab and able_to_drag:
#		if clicked_tile != null:
#			hold_disk = clicked_tile.disk
#			hold_disk.z_index = 99
#			hold_disk.global_position = grabbed_offset+get_global_mouse_position()
#	elif hold_disk!=null and clicked_tile != null and able_to_drag:
#		var empt_tile_mousePos = tile_arr[empt_tile_index].get_local_mouse_position()
#		var epmt_tile_texture = tile_arr[empt_tile_index].get_texture()
#		var inEmptyTile = (empt_tile_mousePos.x >=0 && empt_tile_mousePos.x <= epmt_tile_texture.get_width() && \
#				empt_tile_mousePos.y >= 0 && empt_tile_mousePos.y <= epmt_tile_texture.get_height())
#		if inEmptyTile:
#			clicked_tile.removeDisk()
#			tile_arr[empt_tile_index].setDisk(hold_disk)
#			empt_tile_index = temp_tile_index
#			temp_tile_index=0
#			init_chaining(hold_disk.get_parent())
#		else: 
#			hold_disk.global_position = original_disk_position
#		hold_disk.z_index = 1
#		hold_disk = null
#		clicked_tile = null
#	pass
	
func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab and able_to_drag:
		if clicked_tile != null:
			hold_disk = clicked_tile.disk
			hold_disk.z_index = 99
			hold_disk.global_position = grabbed_offset+get_global_mouse_position()
	elif hold_disk!=null and clicked_tile != null and able_to_drag:
		var empt_tile_mousePos = tile_arr[empt_tile_index].get_local_mouse_position()
		var epmt_tile_texture = tile_arr[empt_tile_index].get_texture()
		var inEmptyTile = (empt_tile_mousePos.x >=0 && empt_tile_mousePos.x <= epmt_tile_texture.get_width() && \
				empt_tile_mousePos.y >= 0 && empt_tile_mousePos.y <= epmt_tile_texture.get_height())
		if inEmptyTile:
			clicked_tile.removeDisk()
			tile_arr[empt_tile_index].setDisk(hold_disk)
			empt_tile_index = temp_tile_index
			temp_tile_index=0
			init_chaining(hold_disk.get_parent())
		else: 
			hold_disk.global_position = original_disk_position
		hold_disk.z_index = 1
		hold_disk = null
		clicked_tile = null
	pass
		
func init_chaining(start_tile):
#	initialize needed information for chaining
	var start_index
	able_to_drag = false
	dir_changed = true
	define_empty_border()
	block_limit = block_time
	for i in range(tile_arr.size()):
		if start_tile == tile_arr[i]:
			start_index=i
	cur_chain_index = start_index
	cur_chain_tile = tile_arr[cur_chain_index]
	cur_chain_disk = cur_chain_tile.disk
	cur_chain_disk_val = cur_chain_disk.trigger_val
	cur_chain_dir = cur_chain_disk.trigger_dir
	prev_chain_disk=cur_chain_disk
	prev_chain_disk_value=cur_chain_disk_val
	prev_chain_index=cur_chain_index
	start_chaining()
	pass
	
func define_border():
#	border definition
	for i in range(num_column):
		border_no_up.append(i)
	for i in range(num_column):
		border_no_down.append(num_slot-(i+1))
	for i in range(num_column):
		border_no_left.append(i*num_column)
	for i in range(num_column):
		border_no_right.append(border_no_left[i]+(num_column-1))
	pass

func define_empty_border():
#	no_up = 0
	empty_tile_border[0]=(empt_tile_index+num_column)
#	no_right = 1
	empty_tile_border[1]=(empt_tile_index-1)
#	no_down = 2
	empty_tile_border[2]=(empt_tile_index-num_column)
#	no_left = 3
	empty_tile_border[3]=(empt_tile_index+1)
	
	if (border_no_up.has(empt_tile_index)):
		empty_tile_border[2]=-1
#		border_no_down.pop_back()
	if (border_no_down.has(empt_tile_index)):
		empty_tile_border[0]=-1
#		border_no_up.pop_back()
	if (border_no_left.has(empt_tile_index)):
		empty_tile_border[1]=-1
#		border_no_right.pop_back()
	if (border_no_right.has(empt_tile_index)):
		empty_tile_border[3]=-1
#		border_no_left.pop_back()
#	print("------")
#	print("border no up: ")
#	for i in border_no_up:
#		print(i)
#	print("----")
#	print("border no down: ")
#	for i in border_no_down:
#		print(i)
#	print("----")
#	print("border no left: ")
#	for i in border_no_left:
#		print(i)
#	print("----")
#	print("border no right: ")
#	for i in border_no_right:
#		print(i)
#	print("-------")
	pass
	
func is_ok_next_dir(dir,indx,disk):
	if (dir == "up" and border_no_up.has(indx)) or (dir == "up" and (empty_tile_border[0]==indx)):
#		print("on_no_up")
		return false
	elif (dir == "down" and border_no_down.has(indx)) or (dir == "down" and (empty_tile_border[2]==indx)):
#		print("on_no_down")
		return false
	elif (dir == "left" and border_no_left.has(indx)) or (dir == "left" and (empty_tile_border[3]==indx)):
#		print("on_no_left")
		return false
	elif (dir == "right" and border_no_right.has(indx)) or (dir == "right" and (empty_tile_border[1]==indx)):
#		print("on_no_right")
		return false
	elif (disk.is_blocked(dir)):
#		print("blocked")
		return false
	else:
		return true
	pass

func check_next():
#	print("---")
#	print("check_next")
	next_chain_index=update_index(cur_chain_dir,cur_chain_index)
	if is_ok_next_dir(cur_chain_dir,cur_chain_index,cur_chain_disk):
#		cur_chain_dir=next_chain_dir
		cur_chain_index=next_chain_index
#		update_index(cur_chain_dir,cur_chain_index)
		update_cur_tile()
	else:
		cur_chain_dir=change_dir(cur_chain_dir)
		next_chain_index = cur_chain_index
		set_prev_chain_disk_value()
#		print("change dir")
		pass
	pass

func change_dir(dir):
#	print("---")
	if dir=="up":
		dir = "left"
#		dir_changed=true
#		print("change from up to left")
	elif dir=="down":
#		dir_changed=true
		dir = "right"
#		print("change from down to right")
	elif dir=="left":
#		dir_changed=true
		dir = "down"
#		print("change from left to down")
	elif dir=="right":
#		dir_changed=true
		dir = "up"
#		print("change from right to up")
#	print("cur_chain_dir: ",dir)
	return dir
		
func update_index(dir,indx):
#	print("---")
#	print("update_cur_index")
	if dir=="up":
		indx -=num_column
	elif dir== "right":
	 	indx +=1
	elif dir== "left":
	 	indx -=1
	elif dir== "down":
	 	indx+=num_column
	return indx
	pass
	
var prev_chain_tile
var prev_chain_disk
func update_cur_tile():
#	print("---")
#	print("update_cur_tile")
	cur_chain_tile = tile_arr[cur_chain_index]
	cur_chain_disk = cur_chain_tile.disk
	prev_chain_tile = tile_arr[prev_chain_index]
	prev_chain_disk = prev_chain_tile.disk
#	yield(get_tree().create_timer(0.9),"timeout")
#	print("dir: ",cur_chain_dir)
#	for i in range(cur_chain_disk.disk_dir_arr.size()):
#		if cur_chain_disk.disk_dir_arr[i] == cur_chain_dir:
#			cur_chain_disk_val = cur_chain_disk.disk_value[i]
	set_prev_chain_disk_value()		
#	chain_me()
	pass
func tile_is_green():
	emit_signal("tile_greened")
	
func set_prev_chain_disk_value():
	if !is_trigger:
		for i in range(cur_chain_disk.disk_dir_arr.size()):
			if cur_chain_disk.disk_dir_arr[i] == cur_chain_dir:
				cur_chain_disk_val = cur_chain_disk.disk_value[i]
#		bug... in is trigger for this prev_chain_disk
		for i in range(prev_chain_disk.disk_dir_arr.size()):
			if prev_chain_disk.disk_dir_arr[i] == cur_chain_dir:
				prev_chain_disk_value = prev_chain_disk.disk_value[i]
#		prev_chain_disk_value = cur_chain_disk_val
#	print("set prev val: ",prev_chain_disk_value)
	chain_me()
#	print("dir_changed", dir_changed)
#	if dir_changed:
#		print("prev val from cur")
#		prev_chain_disk_value = pv
#	else:
#		print("prev val from rot")
#		prev_chain_disk_value = pv
#	chain_me()

func chain_me():
	if (prev_chain_index != cur_chain_index):
#		print("---")
#		print("chain me")
#		print("prev val: ",prev_chain_disk_value)
		cur_chain_disk.set_rotation_time(prev_chain_disk_value)
		cur_chain_disk.start_rot()
#		print("chain: ",cur_chain_count)
		cur_chain_tile.set_chain_label(cur_chain_count)
		emit_signal("disk_spin")
		cur_chain_count-=1
		is_trigger = false
#	dir_changed = false
signal shots_used
func start_chaining():
	is_trigger = true
	emit_signal("shots_used")
	cur_chain_count =chain_limit
	prev_chain_count=cur_chain_count
#	print("----------")
#	print("initial")
#	print("cur_chain_dir: ",cur_chain_dir)
#	print("cur_chain_index: ",cur_chain_index)
#	print("cur_chain_disk_val: ",cur_chain_disk_val)
	while(cur_chain_count>0):
#		print("------")
#		print("start_chaining_loop: ",cur_chain_count)
#		print("----")
#		print("cur_chain_dir: ",cur_chain_dir)
#		print("cur_chain_index: ",cur_chain_index)
#		print("cur_chain_disk_val: ",cur_chain_disk_val)
		check_next()
		if(prev_chain_index == cur_chain_index):
			block_limit-=1
			if block_limit == 0:
				break
			pass
		else:
			if (prev_chain_count>cur_chain_count):
				yield(get_tree().create_timer(wait_time*prev_chain_disk_value),"timeout")
				prev_chain_count=cur_chain_count
				block_limit = block_time
				prev_chain_index=cur_chain_index
#		print("block limit: ",block_limit)
		is_trigger = false
	print("-----------")
	print("end")
#	able to drag temporarily in here for testing
#	later please move it into after calculation
	yield(get_tree().create_timer(1),"timeout")
	able_to_drag = true
	emit_signal("chain_end")
#	queue_free()
	
