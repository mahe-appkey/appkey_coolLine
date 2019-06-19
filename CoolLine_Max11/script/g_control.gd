extends Node

var total_score : int
var rounds_score = Array()
var shots_score = Array()
var total_shots_score : int
const num_rounds = 10
const shots_limit = 4
var num_shots

func _init():
	num_shots = shots_limit
	total_score = 0
	total_shots_score = 0
	for i in range (num_rounds):
		rounds_score.append(0)
	for i in range (shots_limit):
		shots_score.append(0)
	pass

func _ready():
	pass

func calculate_round_score(round_id,score):
	rounds_score[round_id] = score
	pass
