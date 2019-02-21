extends Node

func set_score(player1Score, player2Score):
	$PlayerScore1.set_text(str(player1Score))
	$PlayerScore2.set_text(str(player2Score))