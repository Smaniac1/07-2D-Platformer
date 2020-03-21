extends KinematicBody2D


onready var stomp_area: Area2D = $StompArea2D
onready var Player = get_parent().get_parent().get_node("Player")

export var score: = 30

const FLOOR = Vector2(0,-1)
const GRAVITY = 1
const SPEED = 20

var velocity = Vector2()
var direction = 1


func _physics_process(delta):
	velocity.x = SPEED * direction
	if direction == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	$Sprite.play("Moving")
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall():
		direction *= -1
		$RayCast2D.position.x *= -1
	if $RayCast2D.is_colliding() == false:
		direction *= -1
		$RayCast2D.position.x *= -1
		
	_on_StompArea2D_area_entered()
	pass
	


func _on_StompArea2D_area_entered():
	pass
	#var bodies = $StompArea2D.get_overlapping_bodies()
	#for body in bodies:
	#	if body.name == "Player":
	#		if Player.position.y < $StompArea2D/CollisionShape2D.position.y:
	#			die()
	#		elif Player.position.y - 1> $StompArea2D/CollisionShape2D.position.y:
	#			Player.die()


func die() -> void:
	Player.update_score(score)
	queue_free()
