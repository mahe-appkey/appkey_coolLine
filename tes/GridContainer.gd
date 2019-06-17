extends GridContainer

# signal

# variable
var disk_arr = Array()
#var disk_class = preload("res://CoolLine_Max11/script/disk_class.gd")
var disk_01
func _init():
	pass
	
func _ready():
	disk_01 = load("res://CoolLine_Max11/node/disk_sprite.tscn").instance()
	add_child(disk_01)
	pass
	
func chain_it():
	get_child(0).rotate_disk(1)
	
func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		chain_it()
#		for i in range(7):
#			chain_it()
#			print("rotating",i)
#			yield(get_tree().create_timer(1),"timeout")

		