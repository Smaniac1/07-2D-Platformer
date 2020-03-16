extends Label

var score = 0

func _ready():
	pass 
	
func update_score(p):
	score += p
	text = 'Score: ' + str(score)
