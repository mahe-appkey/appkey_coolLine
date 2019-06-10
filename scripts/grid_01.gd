extends GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	
	var tileArray=[]
	var diskArray=[]
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
			var tileGrid =preload("res://scene/Sprite.tscn").instance()
			tileGrid.position =Vector2((j*tileWidth)+anchoredWidth, (i*tileHeight)+anchoredHeight)
			tileArray[i][j]=tileGrid
			self.add_child(tileArray[i][j])
	for k in range (col):
		diskArray.append([])
		diskArray[k].resize(row)
		for l in range (row):
			var diskGrid =preload("res://scene/disk.tscn").instance()
			diskGrid.position =Vector2((l*tileWidth)+anchoredWidth+32, (k*tileHeight)+anchoredHeight+32)
			diskArray[k][l]=diskGrid
			self.add_child(diskArray[k][l])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
