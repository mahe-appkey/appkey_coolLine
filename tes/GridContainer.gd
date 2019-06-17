extends GridContainer

# signal

# variable
var disk_arr = Array()
#var disk_class = preload("res://CoolLine_Max11/script/disk_class.gd")
onready var disk = preload("res://CoolLine_Max11/node/disk_sprite.tscn")
var do_it = true
func _init():
	pass
	
func _ready():
	var disk_01 = disk.instance()
	add_child(disk_01)
	pass
	
func chain_it():
	print(get_child(0).name)
	get_child(0).rotate_disk(1)
	
func _process(delta):
	yield(get_tree().create_timer(3),"timeout")
	if (do_it == true):
		chain_it()
		do_it=false
	pass
	
#func _input(event):
#	if Input.is_mouse_button_pressed(BUTTON_LEFT):
#		chain_it()
#		for i in range(7):
#			chain_it()
#			print("rotating",i)
#			yield(get_tree().create_timer(1),"timeout")

		