extends TextureRect

var slotIndex
var disk = null
var sprite_img_texture = preload("res://tes_2/img/board_desert.png")
var sprite_img_texture_clear = preload("res://tes_2/img/board_oasis.png")

# width and height of texture for tile
#var widnhei= ((OS.get_window_size().x)/4)-(OS.get_window_size().x/120)
var widnhei

func resize_img(img_texture,w):
	var img = img_texture.get_data()
	img.resize(w,w)
	var new_tex = ImageTexture.new()
	new_tex.create_from_image(img)
	return new_tex

func clear_tile():
	var sprite_img = resize_img(sprite_img_texture_clear,widnhei)
	self.set_texture(sprite_img)
	
func reset_tile():
	var sprite_img = resize_img(sprite_img_texture,widnhei)
	self.set_texture(sprite_img)

func _init(slotIndex):
	self.slotIndex = slotIndex
	name = "diskSlot_%d" % slotIndex
	
# Called when the node enters the scene tree for the first time.
func _ready():
	widnhei = get_parent().get_rect().size.x/get_parent().get_columns()
	var sprite_img = resize_img(sprite_img_texture,widnhei)
	self.set_texture(sprite_img)
	self.set_stretch_mode(6)
	self.anchor_top = 0.5
	self.anchor_right = 0.5
	self.anchor_bottom = 0.5
	self.anchor_left = 0.5
	pass # Replace with function body.

func setDisk(newDisk):
	add_child(newDisk)
	disk = newDisk
	disk.diskSlot = self
	disk.re_position()

func removeDisk():
	remove_child(disk)


