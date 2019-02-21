extends Node

var ball = null
var player1 = null
var player2 = null
var score_board = null
var screen_dimensions = Rect2()

func _ready():
	ball = $Ball
	player1 = $Player1
	player2 = $Player2
	score_board = $ScoreBoard
	screen_dimensions = get_viewport().get_visible_rect()

func award_win_to_player(player):
	player.increment_score()
	score_board.set_score(player1.score, player2.score)

func win(player):
	award_win_to_player(player)
	ball.reset()

func _physics_process(delta):
	if ball.global_position.x > screen_dimensions.end.x:
		win(player1)
	elif ball.global_position.x < screen_dimensions.position.x:
		win(player2)
