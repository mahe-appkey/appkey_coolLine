extends TextureRect

var slotIndex
var disk = null
#var sprite_img_class = preload("res://tes_2/script/tile_sprite.gd")
var sprite_img_texture = preload("res://tes_2/img/backtile_default2.png")
# width and height of texture for tile
var widnhei= ((OS.get_window_size().x)/4)-5


func resize_img(img_texture,w):
	var img = img_texture.get_data()
	img.resize(w,w)
	var new_tex = ImageTexture.new()
	new_tex.create_from_image(img)
	return new_tex
	
func _init(slotIndex):
	var sprite_img = resize_img(sprite_img_texture,widnhei)
	self.slotIndex = slotIndex
	name = "diskSlot_%d" % slotIndex
	self.set_texture(sprite_img)
	self.set_stretch_mode(6)

func setDisk(newDisk):
	add_child(newDisk)
	disk = newDisk
	disk.diskSlot = self
	
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
