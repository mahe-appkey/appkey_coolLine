extends Sprite

signal rotation_done

var diskType
var diskSlot
var angle_rot
var rot_second = 0.2
const rot_amount:int = 90
var cur_rot : int
var cur_update_rot : int
var bef_rot : int = 0
var trigger_dir
var trigger_val
var widnhei
var tween_rot
var rot_arr = [0,-90,-180,-270]
var disk_dir_arr = ["left","up","right","down"]
var disk_value = [0,1,2,3]

func _init(diskName,diskTexture, diskSlot,diskType):
	name = diskName
	self.diskType = diskType
	self.diskSlot = diskSlot
	texture = diskTexture
	
func is_blocked(dir):
	for i in range(disk_dir_arr.size()):
		if disk_dir_arr[i] == dir:
			if disk_value[i] == 0:
				return (true)
			else: return (false)
	pass
	
func random_arr(i):
	randomize()
	return(randi()%i)
	
func resize_img(img_texture,w):
	var img = img_texture.get_data()
	img.resize(w,w)
	var new_tex = ImageTexture.new()
	new_tex.create_from_image(img)
	return new_tex
	
func _ready():
	widnhei = get_parent().get_rect().size.x-5
	texture = resize_img(texture,widnhei)
	var tweens = Tween.new()
	add_child(tweens)
	tween_rot = get_child(0)
	self.set_centered(true)
	re_position()
	self.set_rotation(deg2rad(rot_arr[random_arr(rot_arr.size())]))
	cur_rot=self.get_rotation_degrees()
	cur_update_rot=cur_rot
	update_value_rot()
	
func update_value_rot():
	var delta_rot = abs(cur_update_rot - bef_rot)
	var r_num = 0
	if delta_rot != 0:
		r_num = abs(delta_rot/90)
#	if r_num == 4: r_num = 0
#	print("r_num: ",r_num)
	for i in range(disk_value.size()):
		disk_value[i]+=r_num
		if disk_value[i]>=4:
			disk_value[i]-=4
	update_trigger_direction()
#	print("----------------------------")
#	for i in range(disk_dir_arr.size()):
#		print(disk_dir_arr[i]," : ",disk_value[i])
#	print("----------------------------")
		
func update_trigger_direction():
	for i in range(disk_value.size()):
		if diskType == "trigger_01":
			if disk_value[i] == 1:
				trigger_dir = disk_dir_arr[i]
				trigger_val = 1
		elif diskType == "trigger_02":
			if disk_value[i] == 2:
				trigger_dir = disk_dir_arr[i]
				trigger_val = 2
		elif diskType == "trigger_03":
			if disk_value[i] == 3:
				trigger_dir = disk_dir_arr[i]
				trigger_val = 3
#	print("trigger dir: ",trigger_dir)
	emit_signal("rotation_done")
#	get_parent().get_parent()._on_rotation_done()
#	update_prev_chain_disk_value()
	pass

#func update_prev_chain_disk_value():
#	for i in range(disk_dir_arr.size()):
#		if disk_dir_arr[i] == get_parent().get_parent().cur_chain_dir:
#			get_parent().get_parent().set_prev_chain_disk_value(disk_value[i])
	
func re_position():
	self.position.x=get_parent().get_rect().size.x/2
	self.position.y=get_parent().get_rect().size.y/2

func calculate_rotation(rot_time):
	angle_rot = cur_rot
	if abs(angle_rot) >= 360:
		angle_rot +=360
		print("before angle_rot: ",angle_rot)
	if abs(cur_rot) >= 360:
		cur_rot +=360
		print("before cur_rot: ",cur_rot)
	bef_rot=cur_rot
	angle_rot-= rot_amount*rot_time
	cur_update_rot=angle_rot
	update_value_rot()
	
func rotate_disk(rot_time):
#	tween_rot.interpolate_property(self, "rotation", deg2rad(cur_rot),deg2rad(angle_rot), 0.7, \
#	Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	if rot_time > 0:
		tween_rot.interpolate_property(self, "rotation", deg2rad(cur_rot),deg2rad(angle_rot), rot_second*rot_time, \
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween_rot.start()
#	OS.delay_msec(500*3)
	cur_rot=angle_rot
#	update_value_rot()
	yield(tween_rot,"tween_completed")
	print("rotating: ",angle_rot)
	get_parent().clear_tile()
#	emit_signal("rotation_done")
#	print("after angle_rot: ",angle_rot)
#	print("after cur_rot: ",cur_rot)
#	print("-------------------------------")
	pass
	
var rot_start
var rotation_time
func set_rotation_time(rt):
	rotation_time = rt
	
func start_rot():
	rot_start=true
	
func _physics_process(delta):
	if (rot_start == true):
		calculate_rotation(rotation_time)
		rotate_disk(rotation_time)
#		if rotation_time > 0:
##			calculate_rotation(rotation_time)
#			rotate_disk(rotation_time)
#			pass
		rot_start=false
		
	