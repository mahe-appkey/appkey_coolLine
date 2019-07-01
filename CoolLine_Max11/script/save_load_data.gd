extends Node

var arr_score = Array()
var arr_config = Array()
var score_file = "user://user_score.clm"
var config_file = "user://user_config.cfg"

func delete_save_score():
	var dir = Directory.new()
	if dir.file_exists(score_file):
		dir.remove(score_file)
	pass
	
func reset_config():
	var dir = Directory.new()
	if dir.file_exists(config_file):
		dir.remove(config_file)
	pass

func get_all_score():
	return arr_score
	
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

func load_config():
	var f = File.new()
	if f.file_exists(config_file):
		f.open(config_file, File.READ)
		while not f.eof_reached():
			var config_temp = f.get_csv_line(",")
			if config_temp !=null:
				arr_config.append([\
				str(config_temp[0]),\
				int(config_temp[config_temp.size()-1])])
		arr_config.pop_back()
		f.close()

func save_config(arr_cfg):
	var f = File.new()
	f.open(config_file, File.WRITE)
	for arr in arr_cfg:
		var temp_config_str = \
		str(arr[0])+","+\
		str(arr[1])
		f.store_line(temp_config_str)
	f.close()
	pass

func get_all_config():
	return arr_config

func load_score():
	var f = File.new()
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
	pass

func check_zero(ite):
	if ite<10:
		return ("0"+str(ite))
	else:
		return (str(ite))
	pass

func proc_cur_score(score):
	var temp_score = Array()
	var cur_date = OS.get_date()
	var cur_time = OS.get_time()
	var date_str=(str(cur_date.year)+"/"+check_zero(cur_date.month)+"/"+check_zero(cur_date.day))
	var time_str=(check_zero(cur_time.hour)+":"+check_zero(cur_time.minute)+":"+check_zero(cur_time.second))
	temp_score.append(score)
	temp_score.append(date_str)
	temp_score.append(time_str)
	arr_score.append(temp_score)
	sort_score()
	pass

func _init():
	pass

func _ready():
#	for i in range (20):
#		proc_cur_score(i*30000)
	pass
