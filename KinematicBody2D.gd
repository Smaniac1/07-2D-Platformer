extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 50
const JUMP_HEIGHT = -500

var motion = Vector2()

export(String, FILE, "*.tscn") var level_select



func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		friction = true
		$Sprite.play("Idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, .2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, .05)
	var snap = Vector2.DOWN
	
	motion = move_and_slide_with_snap(motion, snap, UP)
	
	
	if position.y > 650:
		die()
	pass
	
func update_score(p):
	$Camera2D/Score.update_score(p)
	
func _on_EnemyDetector_body_entered():
	var bodies = $EnemyDetector.get_overlapping_bodies()
	for body in bodies:
		if body.name == "Enemy":
				die()
	
func die():
	get_tree().change_scene(level_select)
