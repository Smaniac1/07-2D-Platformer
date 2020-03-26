extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 50
const JUMP_HEIGHT = -500
const BOUNCE_HEIGHT = -650

var motion = Vector2()

export(String, FILE, "*.tscn") var level_select

func _ready():
	$Camera2D/Score.update_score(0)


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
	get_node("/root/Global").score = $Camera2D/Score.score
	
func _on_EnemyDetector_body_entered(body):
	if body.name == "Enemy":
		die()
	if body.name == "Chomp_Globo":
		die()
	for i in range(1,101):
		if body.name == "Enemy" + str(i):
			die()
		if body.name == "Chomp_Globo" + str(i):
			die()

func die():
	$Camera2D/Score.score = 0
	get_node("/root/Global").score = $Camera2D/Score.score
	get_tree().change_scene(level_select)


func _on_StompArea_body_entered(body):
	if body.name == "Enemy":
		body.die()
		motion.y = BOUNCE_HEIGHT
	for i in range(1,201):
		if body.name == "Enemy" + str(i):
			body.die()
			motion.y = BOUNCE_HEIGHT


func _on_Save_pressed():
	get_node("/root/Global").save_data()


func _on_Load_pressed():
	get_node("/root/Global").load_data()
