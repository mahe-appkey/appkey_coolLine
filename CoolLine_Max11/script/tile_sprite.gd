extends Sprite

var sprite_img = preload("res://CoolLine_Max11/img/backtile_default2.png")

var sprite_scale = Vector2()

func _init():
	sprite_scale.x = 0.1
	sprite_scale.y = 0.1
	self.set_texture(sprite_img)
	self.scale = sprite_scale


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
