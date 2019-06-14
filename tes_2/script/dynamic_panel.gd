extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var panel_x = OS.get_window_size().x
var panel_y = OS.get_window_size().y

func _init():
	self.rect_size.x = panel_x
	self.rect_size.y = panel_y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
