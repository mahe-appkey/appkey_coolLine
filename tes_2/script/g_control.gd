extends Node

#var chain_dir
#var chain_rotate_val
#var score_round = []
#var total_score
#var shots_limit = 4
#var cur_disk
#var cur_tile
#var cur_tile_index

#func begin_chaining(tile_ar):
#	cur_tile_index = $Panel/board.get_emtpy_tile_index()
#	cur_disk = tile_ar[cur_tile_index].disk
#	cur_tile = tile_ar[cur_tile_index]
#	chain_dir = cur_disk.trigger_dir
#	chain_rotate_val = cur_disk.trigger_val
#	print("empty tile index: ",cur_tile_index)
#	print("chain dir: ",chain_dir)
#	pass
#
#func chaining_clear(dir):
#	if dir == "up":
#		cur_tile_index = cur_tile_index - $Panel/board.get_columns()
#
#	pass

func _ready():
#	$Panel/board.connect("drop_at_empty",self,"begin_chaining")
	pass
