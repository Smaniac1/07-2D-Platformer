extends KinematicBody2D

const FLOOR = Vector2(0,-1)

var velocity = Vector2(0,90)

func _physics_process(delta):
	velocity = move_and_slide(velocity, FLOOR)
