extends KinematicBody2D

const PADDLE_WIDTH = 16
const PADDLE_HEIGHT = 64
const ACCEL = 2
const MAX_SPEED = 20

export(int, "p1", "p2") var player_number
var motion = Vector2()
var direction = Vector2()
var rect = Rect2()
var score = 0
var screen_dimensions = Rect2()

var player_actions = null

func get_player_number(num):
	return 1 if num == null else 2

func _ready():
	screen_dimensions = get_viewport_rect()
	player_actions = {
		# Player 2 controls
		"up": "ui_up_p2",
		"down": "ui_down_p2"
	} if get_player_number(player_number) == 2 else {
		# Player 1 controls
		"up": "ui_up",
		"down": "ui_down"
	}

func increment_score():
	score += 1

func _physics_process(delta):
	var current_position = global_position
	rect = Rect2(global_position.x, global_position.y, global_position.x + PADDLE_WIDTH, global_position.y + PADDLE_HEIGHT)
	if Input.is_action_pressed(player_actions.up):
		direction.y = -1
	elif Input.is_action_pressed(player_actions.down):
		direction.y = 1
	else:
		direction.y = 0
		motion.y = lerp(motion.y, 0, .9)
	motion.y = clamp(motion.y + (ACCEL * direction.y), -MAX_SPEED, MAX_SPEED)
	move_and_collide(motion)
	if global_position.y < screen_dimensions.position.y:
		set_global_position(Vector2(global_position.x, screen_dimensions.position.y))
	elif global_position.y > screen_dimensions.end.y:
		set_global_position(Vector2(global_position.x, screen_dimensions.end.y))
