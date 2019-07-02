extends OptionButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ar_item = ["4x4","5x5","6x6"]
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range (ar_item.size()):
		add_item(ar_item[i],i)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
