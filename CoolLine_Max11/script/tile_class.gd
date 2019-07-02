extends TextureRect

var slotIndex
var disk = null
var sprite_img_texture = preload("res://CoolLine_Max11/img/tile_01.png")
var sprite_img_texture_clear = preload("res://CoolLine_Max11/img/tile_02.png")
var sprite_img
var sprite_img_clear
var isGreened = false
onready var chain_label = preload("res://CoolLine_Max11/node/node_chain_label.tscn").instance()
onready var p_star_node = preload("res://CoolLine_Max11/node/p_starburst.tscn").instance()
var p_star

var widnhei

func is_green():
	return isGreened

func resize_img(img_texture,w):
	var img = img_texture.get_data()
	img.resize(w,w)
	var new_tex = ImageTexture.new()
	new_tex.create_from_image(img)
	return new_tex

func clear_tile():
	if !isGreened:
		self.set_texture(sprite_img_clear)
		self.isGreened = true
		get_parent().tile_is_green()
		p_star.set_emitting(true)
	
func reset_tile():
	self.set_texture(sprite_img)
	self.isGreened = false

func _init(slotIndex):
	self.slotIndex = slotIndex
	name = "diskSlot_%d" % slotIndex
	
# Called when the node enters the scene tree for the first time.
func _ready():
	widnhei = get_parent().get_rect().size.x/(get_parent().get_columns())
	sprite_img_clear = resize_img(sprite_img_texture_clear,widnhei)
	sprite_img = resize_img(sprite_img_texture,widnhei)
	self.set_texture(sprite_img)
	self.set_stretch_mode(6)
	self.anchor_top = 0.5
	self.anchor_right = 0.5
	self.anchor_bottom = 0.5
	self.anchor_left = 0.5
	chain_label.z_index = 2
	chain_label.set_position(Vector2(widnhei-(widnhei/3),0))
	add_child(chain_label)
	p_star = p_star_node.get_node("Particles2D")
	p_star.set_emitting(false)
	p_star_node.set_position(Vector2(widnhei/2,widnhei/2))
	add_child(p_star_node)
	pass # Replace with function body.
	
func set_chain_label(chain_count):
	chain_label.get_child(0).text = str(chain_count)
	chain_label.get_child(0).get_child(0).play("chain_anim")
	
func setDisk(newDisk):
	add_child(newDisk)
	disk = newDisk
	disk.diskSlot = self
	disk.re_position()

func removeDisk():
	remove_child(disk)


