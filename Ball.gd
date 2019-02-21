extends KinematicBody2D

const SPEED = 7

var motion = Vector2()
var screen_dimensions = Rect2()
var start_pos = null
var bounce_sfx = null

func rand_or(a, b):
	return a if randf() > .5 else b

func reset():
	# must be called after start_pos is initialized in _ready
	set_global_position(start_pos)
	motion.x = rand_or(SPEED, -SPEED)
	motion.y = rand_or(SPEED, -SPEED)
	bounce_sfx = $Bounce

func _ready():
	start_pos = global_position
	screen_dimensions = get_viewport_rect()
	reset()

func _physics_process(delta):
	if global_position.y < screen_dimensions.position.y or global_position.y > screen_dimensions.end.y:
		bounce_sfx.play()
		motion.y = -motion.y
	var collision = move_and_collide(motion)
	if collision:
		bounce_sfx.play()
		var reflect = collision.remainder.bounce(collision.normal)
		motion = motion.bounce(collision.normal)
		move_and_collide(reflect)
