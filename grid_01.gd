extends GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	
	var tileArray=[]
	var tileWidth = 65
	var tileHeight = 65
	var anchoredWidth = 18
	var anchoredHeight = 260
	var col=5
	var row=5
	for i in range (col):
		tileArray.append([])
		tileArray[i].resize(row)
		for j in range (row):
			var tileGrid =preload("res://Sprite.tscn").instance()
			tileGrid.position =Vector2((j*tileWidth)+anchoredWidth, (i*tileHeight)+anchoredHeight)
			tileArray[i][j]=tileGrid
			self.add_child(tileArray[i][j])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
