extends Label

var score = 0

func _ready():
	pass 
	
func update_score(p):
	get_node("/root/Global").score += p
	score = get_node("/root/Global").score
	text = 'Score: ' + str(score)
