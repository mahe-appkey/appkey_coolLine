extends Node

signal score_saved

var cur_score = Array()
var arr_score = Array()
var score_file = "user://user_score.clm"

func delete_save_score():
	var dir = Directory.new()
	if dir.file_exists(score_file):
		dir.remove(score_file)
	pass
	
func sort_score():
	var columnToSort = 0
	var array2DSize = arr_score.size()-1
	for j in range(array2DSize):
		for i in range(array2DSize,0+j,-1):
			if (arr_score[i][columnToSort]) > (arr_score[i-1][columnToSort]):
				var temporaryStore = arr_score[i-1]
				arr_score[i-1] = arr_score[i]
				arr_score[i] = temporaryStore
				
	save_score()

func load_score():
	var f = File.new()
	print(f.file_exists(score_file))
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		while not f.eof_reached():
			var score_temp = f.get_csv_line(",")
			if score_temp !=null:
				arr_score.append([\
				int(score_temp[0]),\
				str(score_temp[score_temp.size()-2]),\
				str(score_temp[score_temp.size()-1])])
		arr_score.pop_back()
		f.close()
		return true
	else:
		return false

func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	for arr in arr_score:
		var temp_score_str = \
		str(arr[0])+","+\
		str(arr[1])+","+\
		str(arr[2])
		f.store_line(temp_score_str)
	f.close()
	print("saved")
	emit_signal("score_saved")
	print("signal")
	pass

func proc_cur_score(score):
	var temp_score = Array()
	var cur_date = OS.get_date()
	var cur_time = OS.get_time()
	var date_str=(str(cur_date.year)+"/"+str(cur_date.month)+"/"+str(cur_date.day))
	var time_str=(str(cur_time.hour)+":"+str(cur_time.minute)+":"+str(cur_time.second))
	temp_score.append(score)
	temp_score.append(date_str)
	temp_score.append(time_str)
	arr_score.append(temp_score)
	sort_score()
	pass

func _init():
	pass

func _ready():
	load_score()
	for arr in arr_score:
		print(str(arr[0])+" "+arr[1]+" "+arr[2])
	delete_save_score()
	pass
