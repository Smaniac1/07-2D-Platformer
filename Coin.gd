extends Area2D

onready var Score_update = get_parent().get_parent().get_node("Player")
const points = 10

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			Score_update.update_score(points)
			queue_free()
