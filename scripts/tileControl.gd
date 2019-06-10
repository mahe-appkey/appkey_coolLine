extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self, "_on_disk_area_enter")
#	pass # Replace with function body.

func _on_disk_area_enter(disk):
	if(disk.get_name()=="disk"):
		disk.position=Vector2(self.position.x +10, self.position.y + 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
