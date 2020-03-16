extends Area2D

onready var Score_update = get_parent().get_node("Player")
var points = 50
export(String, FILE, "*.tscn") var level_select

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			Score_update.update_score(points)
			get_tree().change_scene(level_select)
